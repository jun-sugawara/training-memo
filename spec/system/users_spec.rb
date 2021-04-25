require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すれば新規登録が完了し、トップページに移動する' do
      visit root_path
        expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード（確認）', with: @user.password_confirmation
      fill_in '年齢', with: @user.age
      select '女性', from: 'user_gender'
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      expect(current_path).to eq root_path
      expect(page).to have_content("ログアウト")
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit root_path
        expect(page).to have_content('新規登録')
      visit new_user_registration_path
        fill_in 'ニックネーム', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード（確認）', with: ''
        fill_in '年齢', with: ''
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        expect(current_path).to eq user_registration_path
    end
  end

