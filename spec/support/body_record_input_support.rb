module BodyRecordInputSupport
  def body_record_input(body_record)
    visit new_body_record_path
    fill_in 'body_record_date', with: @body_record.date
    fill_in 'body_record_body_weight', with: @body_record.body_weight
    fill_in 'body_record_fat', with: @body_record.fat
    expect {
      click_on('保存する')
    }.to change { BodyRecord.count }.by(1)
    expect(page).to have_content('保存が完了しました')
  end
end