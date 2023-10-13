class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
  validates_confirmation_of :password
end
