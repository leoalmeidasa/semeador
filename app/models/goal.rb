class Goal < ApplicationRecord
  belongs_to :user

  validates :title, :target_amount, :due_date, presence: true
end
