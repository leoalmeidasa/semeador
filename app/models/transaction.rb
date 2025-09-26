class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum :transaction_type, { income: 0, expense: 1 }
  enum :offering_type, {
    tithe: 0,
    regular_offering: 1,
    special_offering: 2,
    mission_offering: 3,
    thanksgiving_offering: 4,
    construction_offering: 5
  }, _prefix: true

  validates :amount, :date, presence: true
  validates :transaction_type, presence: true , inclusion: { in: %w(income expense) }
  validates :tithe_percentage, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }, allow_nil: true

  scope :tithes_and_offerings, -> { where(is_tithe: true) }
  scope :by_month, ->(date) { where(date: date.beginning_of_month..date.end_of_month) }
  scope :by_year, ->(date) { where(date: date.beginning_of_year..date.end_of_year) }

  def self.calculate_suggested_tithe(income_amount)
    (income_amount * 0.10).round(2)
  end

  def self.total_tithes_for_period(user, start_date, end_date)
    user.transactions
        .tithes_and_offerings
        .where(date: start_date..end_date)
        .sum(:amount)
  end

  def self.tithe_percentage_for_period(user, start_date, end_date)
    total_income = user.transactions
                       .income
                       .where(date: start_date..end_date)
                       .sum(:amount)

    total_tithes = total_tithes_for_period(user, start_date, end_date)

    return 0 if total_income.zero?
    ((total_tithes / total_income) * 100).round(2)
  end
end
