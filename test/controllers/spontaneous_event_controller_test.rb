require "test_helper"

class SpontaneousEventControllerTest < ActionDispatch::IntegrationTest
  test "should show a spontaneous event" do
    get spontaneous_event_show_url(deck_id: decks(:one))
    assert_response :success
  end
end
