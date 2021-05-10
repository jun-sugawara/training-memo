require 'rails_helper'

RSpec.describe BodyRecord, type: :model do
  before do
    @body_record = FactoryBot.build(:body_record)
  end

  describe '体組成記録保存' do
    context '体組成記録が保存できるとき' do
      it '必須項目が適切に入力されていれば体組成記録が保存できる' do
        expect(@body_record).to be_valid
      end
    end

    context '体組成記録が保存できないとき' do
      it '日付が選択されていなければ保存ができない' do
        @body_record.date = nil
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '日付を入力してください'
      end
      it '体重が入力されていなければ保存ができない' do
        @body_record.body_weight = ''
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重を入力してください'
      end
      it '体重は全角半角数字混合では保存ができない' do
        @body_record.body_weight = '５０.5'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体重は半角英数字混合では保存ができない' do
        @body_record.body_weight = 'test50'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体重は全角数字では保存ができない' do
        @body_record.body_weight = '５０．５'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体重は全角かなでは保存ができない' do
        @body_record.body_weight = 'にじゅう'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体重は全角カナでは保存ができない' do
        @body_record.body_weight = 'ニジュウ'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体重は全角漢字では保存ができない' do
        @body_record.body_weight = '二十'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体重は半角数字で入力してください'
      end
      it '体脂肪率が入力されていなければ保存ができない' do
        @body_record.fat = ''
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率を入力してください'
      end
      it '体脂肪率は全角数字では保存ができない' do
        @body_record.fat = '２０．５'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
      it '体脂肪率は全角半角数字混合では保存ができない' do
        @body_record.fat = '２０.5'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
      it '体脂肪率は半角英数字混合では保存ができない' do
        @body_record.fat = 'test20'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
      it '体脂肪率は全角かなでは保存ができない' do
        @body_record.fat = 'にじゅう'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
      it '体脂肪率は全角カナでは保存ができない' do
        @body_record.fat = 'ニジュウ'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
      it '体脂肪率は全角漢字では保存ができない' do
        @body_record.fat = '二十'
        @body_record.valid?
        expect(@body_record.errors.full_messages).to include '体脂肪率は半角数字で入力してください'
      end
    end
  end
end
