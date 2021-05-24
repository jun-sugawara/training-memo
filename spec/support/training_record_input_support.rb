module TrainingRecordInputSupport
  def training_record_input(_training_record)
    visit new_training_record_path
    fill_in 'training_record_date', with: @training_record.date
    select 'ベンチプレス', from: 'training_record_training_event'
    click_on('次へ')
    expect(current_path).to eq next_training_records_path
    fill_in 'training_record_training_weight', with: @training_record.training_weight
    fill_in 'training_record_reps', with: @training_record.set
    select '3', from: 'training_record_set'
    expect do
      click_on('保存する')
    end.to change { TrainingRecord.count }.by(1)
    expect(current_path).to eq user_path(@user)
    expect(page).to have_content('保存が完了しました')
  end
end
