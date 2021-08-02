class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :expenses, through: :lists
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
end
