require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid with mismatching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'wrong_password'
      )
      expect(user).not_to be_valid
    end

    it 'requires a password' do
      user = User.new(email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires a password confirmation' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'requires a unique email and is case-insensitive' do
      existing_user = User.create(email: 'test@example.com', password: 'password')
      new_user = User.new(email: 'test@example.COM', password: 'another_password', password_confirmation: 'another_password')
      expect(new_user).not_to be_valid
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
