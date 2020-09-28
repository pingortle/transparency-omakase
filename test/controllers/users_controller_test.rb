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

  class Authorized < self
    setup do
      login(model: @user)
    end

    test "should update user" do
      original = @user.dup
      patch user_url(@user), params: {user: {login: "new_user", password: "new secret", password_confirmation: "new secret"}}
      assert_equal "new_user", @user.reload.login
      assert_not_equal original.password_digest, @user.reload.password_digest
    end

    test "should not create user" do
      assert_no_difference("User.count") do
        post users_url, params: {user: {login: "new_user", password: "secret", password_confirmation: "secret"}}
      end
    end

    test "should destroy user" do
      assert_difference("User.count", -1) do
        delete user_url(@user)
      end
    end
  end

  class OtherAuthorized < self
    setup do
      login(:two)
    end

    test "should not update user" do
      original = @user.dup
      patch user_url(@user), params: {user: {login: "new_user", password: "new secret", password_confirmation: "new secret"}}
      assert_equal original.login, @user.reload.login
      assert_equal original.password_digest, @user.reload.password_digest
    end

    test "should not create user" do
      assert_no_difference("User.count") do
        post users_url, params: {user: {login: "new_user", password: "secret", password_confirmation: "secret"}}
      end
    end

    test "should not destroy user" do
      assert_no_difference("User.count") do
        delete user_url(@user)
      end
    end
  end

  class Unauthorized < self
    test "should not update user" do
      original = @user.dup
      patch user_url(@user), params: {user: {login: "new_user", password: "new secret", password_confirmation: "new secret"}}
      assert_equal original.login, @user.reload.login
      assert_equal original.password_digest, @user.reload.password_digest
    end

    test "should not create user" do
      assert_no_difference("User.count") do
        post users_url, params: {user: {login: "new_user", password: "secret", password_confirmation: "secret"}}
      end
    end

    test "should not destroy user" do
      assert_no_difference("User.count") do
        delete user_url(@user)
      end
    end
  end
end
