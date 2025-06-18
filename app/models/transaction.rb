class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum :transaction_type, { income: 0, expense: 1 }

  validates :amount, :date, :transaction_type, presence: true
end
