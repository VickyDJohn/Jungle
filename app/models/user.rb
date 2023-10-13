class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
  validates_confirmation_of :password

  def self.authenticate_with_credentials(email, password)
    email = email.to_s.strip
    # Find the user by email (case-insensitive)
    user = User.find_by("lower(email) = ?", email.strip.downcase)

    # Authenticate the user if found and the password matches
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
