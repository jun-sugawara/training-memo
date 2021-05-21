require 'rails_helper'

RSpec.describe 'トレーニング記録保存', type: :system do
  before do
    # @training_genre = FactoryBot.create(:training_genre)
    @training_record = FactoryBot.create(:training_record)
    @user = FactoryBot.create(:user)
  end

  # context 'トレーニング記録の保存ができないとき' do
  #   it 'ログインしていないとトレーニング記録ページへ遷移できない' do
  #     visit root_path
  #     visit user_path(@user.id)
  #     expect(current_path).to eq root_path
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end

  context 'トレーニング記録の保存ができるとき' do
    it 'ログインしたユーザーはトレーニング記録を保存することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      visit user_path(@user.id)
      expect(page).to have_content('トレーニングを記録する')
      # # トレーニング記録ページに遷移する
      click_on('トレーニングを記録する')
      # # フォームに情報を入力する
      fill_in 'training_record_date', with: @training_record.date
      # fill_in 'body_record_fat', with: @body_record.fat
      # 送信するとBodyRecordモデルのカウントが１上がることを確認する
      # binding.pry
      # # 保存が完了しましたの文字があることを確認する
      # expect(page).to have_content('保存が完了しました')
    end
  end

  # context 'トレーニング記録の編集ができないとき' do
  #   it 'ログインしていないとトレーニング確認のページには遷移できない' do
  #     visit root_path
  #     visit user_path(@user.id)
  #     expect(current_path).to eq root_path
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end

  context 'トレーニング記録の編集ができるとき' do
    it 'ログインしたユーザーはトレーニングの記録を編集することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      # ここから編集のテスト
    end
  end

  # context 'トレーニング記録の削除ができないとき' do
  #   it 'ログインしていないとトレーニング確認のページには遷移できない' do
  #     visit root_path
  #     visit user_path(@user.id)
  #     expect(current_path).to eq root_path
  #     expect(page).to have_no_content("マイページへ進む")
  #   end
  # end

  context 'トレーニング記録の削除ができるとき' do
    it 'ログインしたユーザーはトレーニングの記録を削除することができる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
      # ここから削除のテスト
    end
  end

  # 以下全てテスト
  context 'トレーニング記録の確認ができないとき' do
    it '選択された日にトレーニング記録がなければ記録は表示されない' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
    end
  end

  context 'トレーニング記録の確認ができるとき' do
    it 'ログインしたユーザーは自身の登録したデータを日毎に一覧で確認できる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
    end
  end

  context 'トレーニングMAX記録が確認できないとき' do
    it '記録データがなければMAX記録は表示されない' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
    end
  end

  context 'トレーニングMAX記録が確認できないとき' do
    it 'ログインしたユーザーは各種目のMAX記録を確認できる' do
      sign_in(@user)
      expect(page).to have_content('マイページへ進む')
      click_on('マイページへ進む')
    end
  end


end
