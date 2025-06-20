require "test_helper"

class CareLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get care_logs_index_url
    assert_response :success
  end
end
