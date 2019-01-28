require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.new(first_name: "Example",
						 last_name: "User",
						 email: "example@user.com",
						 password: "foobar",
						 password_confirmation: "foobar")
	end

    # Redirect not logged in users to login page
    test "should redirect edit when not logged in" do
  	  get edit_user_registration_path(@user)
  	  assert_not flash.empty?
  	  assert_redirected_to new_user_session_url
    end

    # Redirect not logged in users when trying to update user params
    test "should redirect update when not logged in" do
    	patch user_registration_path(@user), params: { user: { first_name: @user.first_name,
    													  email: @user.email } }
    	assert_not flash.empty?
    	assert_redirected_to new_user_session_url
    end
end
