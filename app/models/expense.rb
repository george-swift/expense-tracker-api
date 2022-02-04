class Expense < ApplicationRecord
  belongs_to :list
  validates :title, presence: true, length: { minimum: 2 }
  validates_numericality_of :amount, greater_than: 0, allow_nil: true
  validates :date, presence: true
  validates :notes, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }

  def as_json(options = nil)
    super({ except: %i[created_at updated_at] }.merge(options || {}))
  end
end
