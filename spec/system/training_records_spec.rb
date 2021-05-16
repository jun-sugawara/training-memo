require 'rails_helper'

RSpec.describe 'トレーニング記録保存', type: :system do
  before do
    @training_record = FactoryBot.create(:training_record)
    @training_genre = FactoryBot.create(:training_genre)
    @user = FactoryBot.create(:user)
  end
  context 'トレーニング記録の保存ができない時' do
    it 'ログインしていないとトレーニング記録ページへ遷移できない' do
      # トップページへ遷移する
      visit root_path
      # 体組成保存ページへのリンクがない
      expect(page).to have_no_content("マイページへ進む")
    end
  end
  context 'トレーニング記録の保存ができる時' do
    it 'ログインしたユーザーはトレーニング記録を保存することができる' do
      # # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on('ログインする')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('マイページへ進む')
      # マイページに遷移する
      visit user_path(@user.id)
      expect(page).to have_content('トレーニングを記録する')
      # # トレーニング記録ページに遷移する
      click_on('トレーニングを記録する')
      # # フォームに情報を入力する
      fill_in 'training_record_date', with: @training_record.date
      # FactoryBot.create_list(:training_record, 1)
      binding.pry
      select training_record.training_event
      # fill_in 'body_record_fat', with: @body_record.fat
      # # 送信するとBodyRecordモデルのカウントが１上がることを確認する
      # expect {
      #   click_on('保存する')
      # }.to change { BodyRecord.count }.by(1)
      # # 保存が完了しましたの文字があることを確認する
      # expect(page).to have_content('保存が完了しました')
    end
  end

end
