require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should show errors when invalid" do
    post sessions_url(session: {login: ""})
    assert_response :success
    assert_match "invalid", response.body
  end

  test "should sign in on valid create" do
    post sessions_url(session: {login: "one", password: "secret"})
    follow_redirect!
    assert_equal "Logged in!", flash[:notice]
  end

  test "should destroy" do
    delete session_url(users(:one))
    assert_redirected_to new_session_url
  end
end
