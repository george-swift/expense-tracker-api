class List < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
