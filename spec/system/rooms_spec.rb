require 'rails_helper'

RSpec.describe 'Delete Room: ', type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'room deleted and so are the messages' do
    # サインインする
    visit root_path
    sign_in(@room_user.user)
    expect(current_path).to eq root_path

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    expect(current_path).to eq room_messages_path(@room_user.room)
    
    # メッセージ情報を5つDBに追加する
    messages = FactoryBot.create_list(:message, 5, room_id: @room_user.room.id, user_id: @room_user.user.id)

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect{find_link('チャットを終了する', href: room_path(@room_user.room)).click}.to change { Message.count }.by(-5)

    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end
end
