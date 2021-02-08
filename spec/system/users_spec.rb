require 'rails_helper'

RSpec.describe 'User Login: ', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'non user gets redirected to sign in' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
  end

  it 'login successful' do
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    sign_in(@user)
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end

  it 'login failed' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    @user.email = "212312"
    @user.password = "223232"
    sign_in(@user)
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq new_user_session_path
  end
end
