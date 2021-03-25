require 'test_helper'

class TrainingRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get training_records_index_url
    assert_response :success
  end

end
