require 'rails_helper'

RSpec.describe 'トレーニング記録保存', type: :system do
  before do
    @training_record = FactoryBot.build(:training_record)
  end
end
