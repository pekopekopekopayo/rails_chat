class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { maximum: 50, minimum: 2 }
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
