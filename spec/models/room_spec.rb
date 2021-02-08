require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'Name params present' do
      expect(@room).to be_valid
    end

    it 'Name is empty' do
      @room.name = ""
      @room.valid?
      expect(@room.errors.full_messages).to include("Name can't be blank")
    end
  end
end
