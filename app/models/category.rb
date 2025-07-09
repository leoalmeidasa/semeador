class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions, dependent: :destroy

  scope :for_user, ->(user) {
    where("user_id IS NULL OR user_id = ?", user.id)
  }

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /\A[a-zA-Z0-9\s-]+\z/, message: "deve conter apenas letras, números, espaços ou hífens" }

  before_save :normalize_name

  private
  def normalize_name
    self.name = name.strip.downcase.capitalize if name.present?
  end
end
