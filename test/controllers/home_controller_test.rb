require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get "/home"
    assert_response :success
    assert_select "title", "Facebook Clone"
  end

end
