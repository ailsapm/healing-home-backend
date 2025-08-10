#load the test helper file
require "test_helper"

#test class for User model
class UserTest < ActiveSupport::TestCase

  #setup method to run before each test
  #initializes a valid user 
  def setup
    @user = User.new(
      username: "testuser",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  #test that user with all required valid attributes is valid
  test "should be valid with all attributes" do
    assert @user.valid?
  end

  #test that username is required
  test "should require a username" do
    @user.username = ""
    assert_not @user.valid?
  end

  #test that usernames must be unique
  test "should require a unique username" do
    @user.save  #save original user
    duplicate_user = @user.dup  #duplicate the user
    duplicate_user.email = "other@example.com"  #change email to avoid email conflict
    assert_not duplicate_user.valid?  #should fail due to dupe username
  end

  #test that email must follow a valid format
  test "should require a valid email format" do
    @user.email = "invalid"
    assert_not @user.valid?
  end

  #test that password must meet minimum length requirement (6 characters)
  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "123"  #too short
    assert_not @user.valid?
  end

  #test that admin? method returns true when admin is set to true
  test "admin? returns true if admin is true" do
    @user.admin = true
    assert @user.admin?
  end

  #test that running soft_delete sets `active` to false
  #and the deleted? method returns true
  test "soft_delete should set active to false" do
    @user.save
    @user.soft_delete
    assert_not @user.active  #active should now be false
    assert @user.deleted?    #deleted? should return true
  end
end
