class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :transactions, dependent: :destroy

  scope :for_user, ->(user) {
    where("user_id IS NULL OR user_id = ?", user.id)
  }
  
  validates :name, presence: true
end
