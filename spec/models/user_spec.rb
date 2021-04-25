require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '必須項目が全て適切に入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'ニックネームが空では登録ができない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'ニックネームが11文字以上では登録ができない' do
        @user.nickname = '11文字以上のニックネーム'
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームは10文字以内で入力してください"
      end
      it 'メールアドレスが空では登録ができない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'メールアドレスに@が含まれていないと登録ができない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it '使用済みのメールアドレスでは登録ができない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it 'パスワードが空では登録ができない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'パスワードが全角英数字混合では登録ができない' do
        @user.password = 'A１A２A３'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'パスワードが５文字以下では登録ができない' do
        @user.password = 'a1a1a'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'パスワードは数字のみでは登録ができない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英数字混合で入力してください'
      end
      it 'パスワードはアルファベットのみでは登録ができない' do
        @user.password = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは半角英数字混合で入力してください'
      end
      it 'パスワードとパスワード（確認）が一致しなければ登録ができない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it '年齢が空では登録ができない' do
        @user.age = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "年齢を入力してください"
      end
      it '年齢は半角数字でなければ登録ができない' do
        @user.age = '２６'
        @user.valid?
        expect(@user.errors.full_messages).to include "年齢は数値で入力してください"
      end
      it '性別が選択されていなければ登録ができない' do
        @user.gender = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "性別を入力してください"
      end
    end
  end
end
