require 'rails_helper'

RSpec.describe TrainingRecord, type: :model do
  before do
    @training_record = FactoryBot.build(:training_record)
  end

  describe 'トレーニング記録保存' do
    context 'トレーニング記録が保存できるとき' do
      it '必須項目が適切に入力されていればトレーニング記録が保存できる' do
        expect(@training_record).to be_valid
      end
    end

    context 'トレーニング記録が保存できないとき' do
      it '日付が選択されていなければ保存ができない' do
        @training_record.date = nil
        @training_record.valid?
        expect(@training_record.errors.full_messages).to include '日付を入力してください'
      end
      it '種目が選択されていなければ保存ができない' do
        @training_record.training_event = ''
        @training_record.valid?
        expect(@training_record.errors.full_messages).to include '種目を入力してください'
      end
      it '重さが入力されていなければ保存ができない' do
        @training_record.training_weight = ''
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さを入力してください'
      end
      it '重さは全角半角数字混合では保存ができない' do
        @training_record.training_weight = '５０.5'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end
      it '重さは半角英数字混合では保存ができない' do
        @training_record.training_weight = 'test50'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end
      it '重さは全角数字では保存ができない' do
        @training_record.training_weight = '５０．５'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end
      it '重さは全角かなでは保存ができない' do
        @training_record.training_weight = 'にじゅう'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end
      it '重さは全角カナでは保存ができない' do
        @training_record.training_weight = 'ニジュウ'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end
      it '重さは全角漢字では保存ができない' do
        @training_record.training_weight = '二十'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '重さは半角数字で入力してください'
      end

      it '回数が入力されていなければ保存ができない' do
        @training_record.reps = ''
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数を入力してください'
      end
      it '回数は全角半角数字混合では保存ができない' do
        @training_record.reps = '５０.5'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it '回数は半角英数字混合では保存ができない' do
        @training_record.reps = 'test50'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it '回数は全角数字では保存ができない' do
        @training_record.reps = '５０．５'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it '回数は全角かなでは保存ができない' do
        @training_record.reps = 'にじゅう'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it '回数は全角カナでは保存ができない' do
        @training_record.reps = 'ニジュウ'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it '回数は全角漢字では保存ができない' do
        @training_record.reps = '二十'
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include '回数は半角数字で入力してください'
      end
      it 'セット数が入力されていなければ保存ができない' do
        @training_record.set = ''
        @training_record.valid?(:next)
        expect(@training_record.errors.full_messages).to include 'セット数を入力してください'
      end
    end
  end
end
