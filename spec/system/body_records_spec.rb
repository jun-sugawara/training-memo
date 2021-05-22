require 'rails_helper'

RSpec.describe '体組成機能', type: :system do
  before do
    @body_record = FactoryBot.create(:body_record)
    @user = FactoryBot.create(:user)
  end

  context '体組成の保存ができないとき' do
    it 'ログインしていないと体組成ページへ遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content("マイページへ進む")
    end
  end

  context '体組成の保存ができるとき' do
    it 'ログインしたユーザーは体組成の記録を保存することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      visit user_path(@user)
      expect(page).to have_content('体重・体脂肪を記録する')
      body_record_input(@body_record)
    end
  end

  context '体組成の編集ができないとき' do 
    it 'ログインしていないと体組成のページには遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content("マイページへ進む")
    end
  end

  context '体組成の編集ができるとき' do
    it 'ログインしたユーザーは体組成の記録を編集することができる' do
      sign_in(@user) 
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      expect(page).to have_content('体重・体脂肪を記録する')
      body_record_input(@body_record)
      click_on('体重・体脂肪を確認する')
      expect(page).to have_content(@body_record.date)
      expect(page).to have_content(@body_record.body_weight)
      expect(page).to have_content(@body_record.fat)
      click_on('編集する')
      expect(current_path).to eq edit_body_record_path(@body_record.id + 1)
      fill_in 'body_record_body_weight', with: 70.0
      fill_in 'body_record_fat', with: 20.0
      expect{
        click_on('保存する')
      }.to change { BodyRecord.count }.by(0)
      expect(page).to have_content('編集が完了しました')
      expect(page).to have_content('70.0')
      expect(page).to have_content('20.0')
    end
  end
  
  context '体組成の削除ができないとき' do 
    it 'ログインしていないと体組成のページには遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content("マイページへ進む")
    end
  end

  context '体組成の削除ができるとき' do
    it 'ログインしたユーザーは体組成の記録を削除することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      body_record_input(@body_record)
      click_on('体重・体脂肪を確認する')
      expect(page).to have_content(@body_record.date)
      expect(page).to have_content(@body_record.body_weight)
      expect(page).to have_content(@body_record.fat)
      expect {
          click_on('削除する')
        }.to change { BodyRecord.count }.by(-1)
        expect(current_path).to eq(body_records_path)
        expect(page).to have_content('削除が完了しました')
      end
    end

  context '体組成の記録が確認できないとき' do
    it 'データがなければ記録は表示されない' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      body_record_input(@body_record)
      click_on('体重・体脂肪を確認する')
      expect(page).to have_content('見たい日付を選択してください')
      fill_in 'body_record_date', with: '002021-06-01'
      click_on('確認する')
      expect(page).to have_content('選択された日の体重・体脂肪データがありません')
    end
  end
    
  context '体組成の記録が確認できるとき' do
    it 'ログインしたユーザーは自身の登録したデータを確認できる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      body_record_input(@body_record)
      click_on('体重・体脂肪を確認する')
      expect(page).to have_content('見たい日付を選択してください')
      fill_in 'body_record_date', with: @body_record.date
      click_on('確認する')      
      expect(page).to have_content(@body_record.date)
      expect(page).to have_content(@body_record.body_weight)
      expect(page).to have_content(@body_record.fat)
    end
  end
end

RSpec.describe '体組成グラフ確認機能', type: :system do
  before do
    # @body_record1 = FactoryBot.create(:body_record)
    # @body_record2 = FactoryBot.create(:body_record)
    # @body_record3 = FactoryBot.create(:body_record)
    @user = FactoryBot.create(:user)
  end

  context '体組成のグラフが確認できないとき' do
    it '記録された最新のデータより後の日付を入力するとグラフは表示されない' do
      sign_in(@user)
      visit user_path(@user.id)
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-01'
      fill_in 'body_record_body_weight', with: '60.5'
      fill_in 'body_record_fat', with: '15'
      click_on('保存する')
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-10'
      fill_in 'body_record_body_weight', with: '56.5'
      fill_in 'body_record_fat', with: '14.2'
      click_on('保存する')
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-20'
      fill_in 'body_record_body_weight', with: '53'
      fill_in 'body_record_fat', with: '12.5'
      click_on('保存する')
      click_on('体重・体脂肪を確認する')
      click_on('推移をグラフで確認する')
      fill_in 'body_record_month', with: '002021-05-30'
      find('#body_record_month_graph').click
      expect(page).to have_content('No data')
    end
  end

  context '体組成のグラフが確認できるとき' do
    it 'ログインしたユーザーは登録された体組成データのグラフを確認できる' do
      sign_in(@user)
      visit user_path(@user.id)
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-01'
      fill_in 'body_record_body_weight', with: '60.5'
      fill_in 'body_record_fat', with: '15'
      click_on('保存する')
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-10'
      fill_in 'body_record_body_weight', with: '56.5'
      fill_in 'body_record_fat', with: '14.2'
      click_on('保存する')
      click_on('体重・体脂肪を記録する')
      fill_in 'body_record_date', with: '002021-05-20'
      fill_in 'body_record_body_weight', with: '53'
      fill_in 'body_record_fat', with: '12.5'
      click_on('保存する')
      click_on('体重・体脂肪を確認する')
      click_on('推移をグラフで確認する')
      fill_in 'body_record_month', with: '002021-05-01'
      find('#body_record_month_graph').click
      # ここからグラフが存在し、データが入っていることの確認の記述
      # binding.pry
    end
  end
end