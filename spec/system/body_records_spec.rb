require 'rails_helper'

RSpec.describe '体組成記録保存', type: :system do
  before do
    @body_record = FactoryBot.build(:body_record)
  end
  context '体組成の保存ができる時' do
    it 'ログインしたユーザーは体組成の記録を保存することができる' do
      # ログインする
      visit new_user_session_path
      # マイページに遷移する

      # 体組成保存ページに遷移する
      # フォームに情報を入力する
      # 送信するとBodyRecordモデルのカウントが１上がることを確認する
      # 保存が完了しましたの文字があることを確認する
    end
  end
  context '体組成の保存ができない時' do
    it 'ログインしていないと体組成ページへ遷移できない' do
      # トップページへ遷移する
      # 体組成保存ページへのリンクがない
    end
  end
end
