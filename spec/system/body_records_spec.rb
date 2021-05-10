require 'rails_helper'

RSpec.describe '体組成記録保存', type: :system do
  before do
    @body_record = FactoryBot.build(:body_record)
    @user = FactoryBot.create(:user)
  end
  context '体組成の保存ができない時' do
    it 'ログインしていないと体組成ページへ遷移できない' do
      # トップページへ遷移する
      visit root_path
      # 体組成保存ページへのリンクがない
      expect(page).to have_no_content("マイページへ進む")
    end
  end
  context '体組成の保存ができる時' do
    it 'ログインしたユーザーは体組成の記録を保存することができる' do
      # # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on('ログインする')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('マイページへ進む')
      # マイページに遷移する
      visit user_path(@user.id)
      expect(page).to have_content('体重・体脂肪を記録する')
      # 体組成保存ページに遷移する
      visit new_body_record_path
      # フォームに情報を入力する
      fill_in 'body_record_date', with: @body_record.date
      fill_in 'body_record_body_weight', with: @body_record.body_weight
      fill_in 'body_record_fat', with: @body_record.fat
      # 送信するとBodyRecordモデルのカウントが１上がることを確認する
      expect {
        click_on('保存する')
      }.to change { BodyRecord.count }.by(1)
      # 保存が完了しましたの文字があることを確認する
      expect(page).to have_content('保存が完了しました')
    end
  end
end
