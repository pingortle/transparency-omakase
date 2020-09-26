require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should not update user" do
    original = @user.dup
    patch user_url(@user), params: {user: {email: "new@example.com", password: "new secret", password_confirmation: "new secret"}}
    assert_equal original.email, @user.reload.email
    assert_equal original.password_digest, @user.reload.password_digest
  end

  test "should create user" do
    assert_no_difference("User.count") do
      post users_url, params: {user: {email: "new@example.com", password: "secret", password_confirmation: "secret"}}
    end
  end

  test "should not destroy user" do
    assert_no_difference("User.count") do
      delete user_url(@user)
    end
  end
end
