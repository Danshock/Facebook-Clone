require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(first_name: "Random", last_name: "User", 
  					email: "random_user@example.com", password: "password", 
  					password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # Test Validations for present fields
  test "first name should be present" do
  	@user.first_name = "     "
  	assert_not @user.valid?
  end

  test "last name should be present" do
  	@user.last_name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "     "
  	assert_not @user.valid?
  end

  test "password should be present" do
  	@user.password = "     "
  	assert_not @user.valid?
  end

  # Test Validations for length
  test "first and last name should not be too long" do
    @user.first_name = "d" * 51
    assert_not @user.valid?
    @user.last_name  = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "d" * 250 + "@example.com"
  	assert_not @user.valid?
  end

  # Test for valid and invalid email addresses
  test "email validation should accept valid addresses" do
  	valid_addresses = %w[random@example.com RANDOM@foo.COM A_RAN-DOM@foo.bar.org first.last@foo.jp tom+jerry@baz.cn]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[random@example,com random_at_foo.org random@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
    	@user.email = invalid_address
    	assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  # test for uniqness in email addresses
  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  # test for lowercase emails
  test "email addresses should be save as a lower-case" do
  	mixed_case_email_example = "Foo@ExAmPLe.CoM"
  	@user.email = mixed_case_email_example
  	@user.save
  	assert_equal mixed_case_email_example.downcase, @user.reload.email
  end
end
