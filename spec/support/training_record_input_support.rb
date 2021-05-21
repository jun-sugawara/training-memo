module TrainingRecordInputSupport
  def training_record_input(training_record)
    visit new_training_record_path
    fill_in 'training_record_date', with: @body_record.date
    # 入力サポートを記述
    expect {
      click_on('保存する')
    }.to change { TrainingRecord.count }.by(1)
    expect(page).to have_content('保存が完了しました')
  end
end