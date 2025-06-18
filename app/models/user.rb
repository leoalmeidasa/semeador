class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions
  has_many :categories
  has_many :budgets
  has_many :goals
end
