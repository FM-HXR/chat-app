require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create: ' do
    before do
      @user = FactoryBot.create(:user)
      @room = FactoryBot.create(:room)
      @message = FactoryBot.build(:message)
    end

    it 'content & image present' do
      expect(@message).to be_valid
    end

    it 'does not need content' do
      @message.content = ""
      expect(@message).to be_valid
    end

    it 'does not need image' do
      @message.image = nil
      expect(@message).to be_valid
    end

    it 'content and image empty' do
      @message.content = ""
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end

    it 'no room' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end

    it 'no user' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end
  end
end
