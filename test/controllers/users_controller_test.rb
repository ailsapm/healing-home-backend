require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  #test that a user is successfully created when valid parameters are passed
  test "should create user with valid params" do
    #assert that the User count increases by 1
    assert_difference("User.count", 1) do
      post "/users", params: {
        user: {
          username: "newuser",
          email: "newuser@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    #expect HTTP 201 Created
    assert_response :created

    #parse the JSON response and check that the username is correct
    body = JSON.parse(response.body)
    assert_equal "newuser", body["user"]["username"]
  end

  #test that creating a user with an invalid email fails
  test "should not create user with invalid email" do
    #assert that no new User is created
    assert_no_difference("User.count") do
      post "/users", params: {
        user: {
          username: "baduser",
          email: "notanemail", # invalid format
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    #expect HTTP 422 Unprocessable Entity
    assert_response :unprocessable_entity

    #check that the error message includes "Email"
    body = JSON.parse(response.body)
    assert_includes body["errors"].join, "Email"
  end

  # Test that missing password confirmation results in validation failure
  test "should not create user with missing password confirmation" do
    #assert that no new User is created
    assert_no_difference("User.count") do
      post "/users", params: {
        user: {
          username: "missingpw",
          email: "user@example.com",
          password: "password",
          #password_confirmation is missing here on purpose
        }
      }
    end

    #expect HTTP 422 Unprocessable Entity
    assert_response :unprocessable_entity
  end
end
