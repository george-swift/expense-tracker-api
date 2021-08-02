class List < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { minimum: 3, maximum: 40 }
end
