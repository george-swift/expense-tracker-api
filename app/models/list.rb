class List < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { minimum: 3, maximum: 40 }

  def as_json(options = nil)
    super({ only: %i[id name] }.merge(options || {}))
  end
end
