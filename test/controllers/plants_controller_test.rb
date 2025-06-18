require "test_helper"

class PlantsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get plants_show_url
    assert_response :success
  end

  test "should get water" do
    get plants_water_url
    assert_response :success
  end

  test "should get do_quest" do
    get plants_do_quest_url
    assert_response :success
  end
end
