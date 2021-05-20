require 'rails_helper'

# RSpec.describe '体組成機能', type: :system do
#   before do
#     @body_record = FactoryBot.create(:body_record)
#     @user = FactoryBot.create(:user)
#   end

  # context '体組成の保存ができない時' do
  #   it 'ログインしていないと体組成ページへ遷移できない' do
  #     # トップページへ遷移する
  #     visit root_path
  #     # 体組成保存ページへのリンクがない
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end
  # context '体組成の保存ができる時' do
  #   it 'ログインしたユーザーは体組成の記録を保存することができる' do
  #     #  ログインする
  #     sign_in(@user)
  #     expect(page).to have_content('マイページへ進む')
  #     # マイページに遷移する
  #     visit user_path(@user.id)
  #     expect(page).to have_content('体重・体脂肪を記録する')
  #     body_record_input(@body_record)
  #   end
  # end

  # context '体組成の編集ができないとき' do 
  #   it 'ログインしていないと体組成のページには遷移できない' do
  #     visit root_path
  #     visit user_path(@user.id)
  #     expect(current_path).to eq root_path
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end

  # context '体組成の編集ができるとき' do
  #   it 'ログインしたユーザーは体組成の記録を編集することができる' do
  #     # ログインする
  #     sign_in(@user) 
  #     expect(page).to have_content('マイページへ進む')
  #     # マイページに遷移する
  #     visit user_path(@user.id)
  #     expect(page).to have_content('体重・体脂肪を記録する')
  #     body_record_input(@body_record)
  #     visit body_records_path
  #     expect(page).to have_content(@body_record.date)
  #     expect(page).to have_content(@body_record.body_weight)
  #     expect(page).to have_content(@body_record.fat)
  #     click_on('編集する')
  #     expect(current_path).to eq edit_body_record_path(@body_record.id + 1)
  #     fill_in 'body_record_body_weight', with: 70.0
  #     fill_in 'body_record_fat', with: 20.0
  #     click_on('保存する')
  #     expect(page).to have_content('編集が完了しました')
  #     expect(page).to have_content('70.0')
  #     expect(page).to have_content('20.0')
  #   end
  # end
  
  # context '体組成の削除ができないとき' do 
  #   it 'ログインしていないと体組成のページには遷移できない' do
  #     visit root_path
  #     visit user_path(@user.id)
  #     expect(current_path).to eq root_path
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end

  # context '体組成の削除ができるとき' do
  #   it 'ログインしたユーザーは体組成の記録を削除することができる' do
  #     sign_in(@user)
  #     expect(page).to have_content('マイページへ進む')
  #     # マイページに遷移する
  #     visit user_path(@user.id)
  #     expect(page).to have_content('体重・体脂肪を記録する')
  #     body_record_input(@body_record)
  #     visit body_records_path
  #     expect {
  #       click_on('削除する')
  #     }.to change { BodyRecord.count }.by(-1)
  #     expect(current_path).to eq(body_records_path)
  #     expect(page).to have_content('削除が完了しました')
  #   end
  # end

#   context '保存した体組成の記録を確認するとき' do
#     it 'ログインしたユーザーは自身の登録したデータを確認できる' do
#       sign_in(@user)
#       expect(page).to have_content('マイページへ進む')
#       visit user_path(@user.id)
#       body_record_input(@body_record)
#       visit body_records_path
#       expect(page).to have_content('見たい日付を選択してください')
#       fill_in 'body_record_date', with: @body_record.date
#       click_on('確認する')      
#       expect(page).to have_content(@body_record.date)
#       expect(page).to have_content(@body_record.body_weight)
#       expect(page).to have_content(@body_record.fat)
#     end
#   end
#   context '太祖性の記録が確認できないとき' do
#     it 'データがなければ記録は表示されない' do
#       sign_in(@user)
#       expect(page).to have_content('マイページへ進む')
#       visit user_path(@user.id)
#       body_record_input(@body_record)
#       visit body_records_path
#       expect(page).to have_content('見たい日付を選択してください')
#       fill_in 'body_record_date', with: '002021-06-01'
#       click_on('確認する')
#       expect(page).to have_content('選択された日の体重・体脂肪データがありません')
#     end
#   end
# end

RSpec.describe '体組成グラフ確認機能', type: :system do
  before do
    @body_record1 = FactoryBot.create(:body_record)
    @body_record2 = FactoryBot.create(:body_record)
    @body_record3 = FactoryBot.create(:body_record)
    @user = FactoryBot.create(:user)
  end
  context '体組成のグラフが確認できるとき', js: true do
    it 'ログインしたユーザーは登録された体組成データのグラフを確認できる' do
      sign_in(@user)
      visit user_path(@user.id)
      visit new_body_record_path
      fill_in 'body_record_date', with: @body_record1.date
      fill_in 'body_record_body_weight', with: @body_record1.body_weight
      fill_in 'body_record_fat', with: @body_record1.fat
      expect {
        click_on('保存する')
      }.to change { BodyRecord.count }.by(1)
      expect(page).to have_content('保存が完了しました')
      visit new_body_record_path
      fill_in 'body_record_date', with: @body_record2.date
      fill_in 'body_record_body_weight', with: @body_record2.body_weight
      fill_in 'body_record_fat', with: @body_record2.fat
      expect {
        click_on('保存する')
      }.to change { BodyRecord.count }.by(1)
      expect(page).to have_content('保存が完了しました')
      visit new_body_record_path
      fill_in 'body_record_date', with: @body_record3.date
      fill_in 'body_record_body_weight', with: @body_record3.body_weight
      fill_in 'body_record_fat', with: @body_record3.fat
      expect {
        click_on('保存する')
      }.to change { BodyRecord.count }.by(1)
      expect(page).to have_content('保存が完了しました')

      visit body_records_path
      click_on('推移をグラフで確認する')
      fill_in 'body_record_month', with: '002021-05-01'
      find('#body_record_month').click
      # グラフを確認する方法がわからない
      binding.pry
      
    end
  end
end