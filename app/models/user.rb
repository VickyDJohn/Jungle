class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
end
