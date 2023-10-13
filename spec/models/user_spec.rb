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
      existing_user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      new_user = User.new(email: 'test@example.COM', password: 'another_password', password_confirmation: 'another_password')
      expect(new_user).not_to be_valid
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires password to be minimum 8 characters' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end
  end

  describe 'authenticate_with_credentials' do
    it 'authenticates with valid credentials' do
      user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')

      expect(authenticated_user).to eq(user)
    end

    it 'does not authenticate with invalid email' do
      User.create(email: 'test@example.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('invalid@example.com', 'password')

      expect(authenticated_user).to be_nil
    end

    it 'does not authenticate with invalid password' do
      User.create(email: 'test@example.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')

      expect(authenticated_user).to be_nil
    end

    it 'authenticates with trailing and leading whitespaces in email' do
      user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')

      expect(authenticated_user).to eq(user)
    end

    it 'authenticates with case-insensitive email' do
      user = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')

      expect(authenticated_user).to eq(user)
    end
  end
end
