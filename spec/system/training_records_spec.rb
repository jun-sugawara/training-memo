require 'rails_helper'

RSpec.describe 'トレーニング記録機能', type: :system do
  before do
    @training_record = FactoryBot.create(:training_record)
    @user = FactoryBot.create(:user)
  end

  context 'トレーニング記録の保存ができないとき' do
    it 'ログインしていないとトレーニング記録ページへ遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('マイページへ進む')
    end
  end

  context 'トレーニング記録の保存ができるとき' do
    it 'ログインしたユーザーはトレーニング記録を保存することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      visit user_path(@user)
      expect(page).to have_content('トレーニングを記録する')
      training_record_input(@training_record)
    end
  end

  context 'トレーニング記録の編集ができないとき' do
    it 'ログインしていないとトレーニング確認のページには遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('マイページへ進む')
    end
  end

  context 'トレーニング記録の編集ができるとき' do
    it 'ログインしたユーザーはトレーニングの記録を編集することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを確認する')
      expect(page).to have_content(@training_record.date)
      expect(page).to have_content('ベンチプレス')
      expect(page).to have_content(@training_record.training_weight)
      expect(page).to have_content(@training_record.reps)
      expect(page).to have_content(@training_record.set)
      click_on('編集する')
      fill_in 'training_record_training_weight', with: 80.0
      fill_in 'training_record_reps', with: 5.0
      select '5', from: 'training_record_set'
      expect do
        click_on('保存する')
      end.to change { TrainingRecord.count }.by(0)
      expect(current_path).to eq training_records_path
      expect(page).to have_content('編集が完了しました')
      expect(page).to have_content('80.0kg')
      expect(page).to have_content('5回')
      expect(page).to have_content('5セット')
    end
  end

  context 'トレーニング記録の削除ができないとき' do
    it 'ログインしていないとトレーニング確認のページには遷移できない' do
      visit root_path
      visit user_path(@user.id)
      expect(current_path).to eq root_path
      expect(page).to have_no_content('マイページへ進む')
    end
  end

  context 'トレーニング記録の削除ができるとき' do
    it 'ログインしたユーザーはトレーニングの記録を削除することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを確認する')
      expect(page).to have_content(@training_record.date)
      expect(page).to have_content('ベンチプレス')
      expect(page).to have_content(@training_record.training_weight)
      expect(page).to have_content(@training_record.reps)
      expect(page).to have_content(@training_record.set)
      expect do
        click_on('削除する')
      end.to change { TrainingRecord.count }.by(-1)
      expect(current_path).to eq training_records_path
      expect(page).to have_content('削除が完了しました')
    end
  end

  context 'トレーニング記録の確認ができないとき' do
    it '選択された日にトレーニング記録がなければ記録は表示されない' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを確認する')
      expect(page).to have_content('見たい日付を選択してください')
      fill_in 'training_record_date', with: '002021-05-10'
      click_on('確認する')
      expect(page).to have_content('記録されたデータがありません')
    end
  end

  context 'トレーニング記録の確認ができるとき' do
    it 'ログインしたユーザーは自身の登録したデータを日毎に一覧で確認できる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを記録する')
      fill_in 'training_record_date', with: '002021-05-01'
      select 'デッドリフト', from: 'training_record_training_event'
      click_on('次へ')
      expect(current_path).to eq next_training_records_path
      fill_in 'training_record_training_weight', with: '100'
      fill_in 'training_record_reps', with: '3'
      select '5', from: 'training_record_set'
      click_on('保存する')
      expect(current_path).to eq user_path(@user)
      click_on('トレーニングを確認する')
      expect(page).to have_content('見たい日付を選択してください')
      fill_in 'training_record_date', with: '002021-05-01'
      click_on('確認する')
      expect(page).to have_content(@training_record.date)
      expect(page).to have_content('ベンチプレス')
      expect(page).to have_content(@training_record.training_weight)
      expect(page).to have_content(@training_record.reps)
      expect(page).to have_content(@training_record.set)
      expect(page).to have_content('2021-05-01')
      expect(page).to have_content('デッドリフト')
      expect(page).to have_content('100.0kg')
      expect(page).to have_content('3回')
      expect(page).to have_content('5セット')
    end
  end

  context 'トレーニングMAX記録が確認できないとき' do
    it '記録データがなければMAX記録は表示されない' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを確認する')
      click_on('Max重量を確認する')
      expect(current_path).to eq max_training_records_path
      select 'スクワット', from: 'training_record_training_event'
      click_on('確認する')
      expect(current_path).to eq max_search_training_records_path
      expect(page).to have_content('選択された種目のトレーニング履歴がありません')
    end
  end

  context 'トレーニングMAX記録が確認できるとき' do
    it 'ログインしたユーザーは各種目のMAX記録を確認できる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      training_record_input(@training_record)
      click_on('トレーニングを記録する')
      fill_in 'training_record_date', with: @training_record.date
      select 'デッドリフト', from: 'training_record_training_event'
      click_on('次へ')
      expect(current_path).to eq next_training_records_path
      fill_in 'training_record_training_weight', with: '150'
      fill_in 'training_record_reps', with: '1'
      select '1', from: 'training_record_set'
      click_on('保存する')
      click_on('トレーニングを確認する')
      click_on('Max重量を確認する')
      expect(current_path).to eq max_training_records_path
      select 'デッドリフト', from: 'training_record_training_event'
      click_on('確認する')
      expect(current_path).to eq max_search_training_records_path
      expect(page).to have_content('MAX重量')
      expect(page).to have_content('150.0kg')
      expect(page).to have_content('達成した日付')
      expect(page).to have_content(@training_record.date)
    end
  end
end
