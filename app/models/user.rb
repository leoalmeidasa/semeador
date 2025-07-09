class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "formato de email inválido" }
  validates :password, presence: true, length: { minimum: 8, maximum: 20 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  before_save { self.email = email.downcase }

  private
  )
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  has_many :transactions
  has_many :categories
  has_many :budgets
  has_many :goals
end
