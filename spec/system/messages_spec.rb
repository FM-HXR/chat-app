require 'rails_helper'

RSpec.describe 'Send Chat Message: ', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
    @message = FactoryBot.create(:message)
  end

  context 'Send Failed: ' do
    it 'content empty' do
      # サインインする
      visit root_path
      sign_in(@room_user.user)
      expect(current_path).to eq root_path

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      expect(current_path).to eq room_messages_path(@room_user.room)
     
      # DBに保存されていないことを確認する
      expect{find('input[name="commit"]').click}.not_to change { Message.count }
    
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq root_path
    end
  end

  context 'Send Successful: ' do
    it 'redir to messages top of :room_id' do
      # サインインする
      visit root_path
      sign_in(@room_user.user)
      expect(current_path).to eq root_path

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 値をテキストフォームに入力する
      fill_in 'message_content', with: @message.content
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@message.content)
    end

    it 'image upload successful' do
      # サインインする
      visit root_path
      sign_in(@room_user.user)
      expect(current_path).to eq root_path

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      expect(current_path).to eq room_messages_path(@room_user.room)

      # define image path and attach to input.
      image_path = Rails.root.join('public/images/test_image.png')
      
      # this finds the file-type input element with name="message[image]" and attaches file suggested in path. 
      # image_path, not be confused with image_tag erb helper
      attach_file('message[image]', image_path, make_visible: true)      
  
      # 送信した値がDBに保存されていることを確認する
      expect{find("input[name='commit']").click}.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector ".message-image"

    end

    it 'content & image both successful' do
      # サインインする
      visit root_path
      sign_in(@room_user.user)
      expect(current_path).to eq root_path

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      expect(current_path).to eq room_messages_path(@room_user.room)

      # define image path and attach to input.
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('message[image]', image_path, make_visible: true)    

      # 値をテキストフォームに入力する
      fill_in 'message_content', with: @message.content

      # 送信した値がDBに保存されていることを確認する
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      expect(current_path).to eq room_messages_path(@room_user.room)
      
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@message.content)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector ".message-image"

    end
  end
end
