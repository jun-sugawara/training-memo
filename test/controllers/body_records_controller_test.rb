require 'test_helper'

class BodyRecordsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get body_records_index_url
    assert_response :success
  end
end
