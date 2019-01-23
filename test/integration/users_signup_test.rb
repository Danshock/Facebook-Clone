require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

  # Test for invalid sign up submission
  test "invalid signup information" do
  	get new_user_registration_path
  	assert_equal 200, status
    assert_no_difference "User.count" do
  	  post user_registration_path, params: { user: { first_name: "",
  												     last_name:  "example",
  												     email: "random@example.com",
  												     password: "password",
  												     password_confirmation: "password" } }
      end
  end
end
