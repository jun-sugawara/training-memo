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
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'ニックネームが11文字以上では登録ができない' do
        @user.nickname = '11文字以上のニックネーム'
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname is too long (maximum is 10 characters)"
      end
      it 'メールアドレスが空では登録ができない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'メールアドレスに@が含まれていないと登録ができない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '使用済みのメールアドレスでは登録ができない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'パスワードが空では登録ができない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードが全角英数字混合では登録ができない' do
        @user.password = 'A１A２A３'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'パスワードが５文字以下では登録ができない' do
        @user.password = 'a1a1a'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードは数字のみでは登録ができない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it 'パスワードはアルファベットのみでは登録ができない' do
        @user.password = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it 'パスワードとパスワード（確認）が一致しなければ登録ができない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '年齢が空では登録ができない' do
        @user.age = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Age can't be blank"
      end
      it '年齢は半角数字でなければ登録ができない' do
        @user.age = '２６'
        @user.valid?
        expect(@user.errors.full_messages).to include "Age is not a number"
      end
      it '性別が空では登録ができない' do
        @user.gender = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Gender can't be blank"
      end
    end
  end
end
