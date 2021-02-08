require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create: ' do
    before do
      @user = FactoryBot.build(:user)
      @user_1 = FactoryBot.create(:user)
    end

    it 'All form info present' do
      expect(@user).to be_valid
    end

    it 'Name is empty' do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'Email is empty' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'Password is empty' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
    end

    it 'Password >= 6 characters' do
      @user.password = "aaaaaa"
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it 'Password <= 5 characters' do
      @user.password = "aaaaa"
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'Password != Confirmation' do
      @user.password = "aaaaaa"
      @user.password_confirmation = "bbbbbb"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  
    it 'Email Taken' do
      @user.email = @user_1.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end  
    
  end
end
