require "test_helper"

class DecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deck = decks(:one)
  end

  test "should get index" do
    get decks_url
    assert_response :success
  end

  test "should get new" do
    get new_deck_url
    assert_response :success
  end

  test "should show deck" do
    get deck_url(@deck)
    assert_response :success
  end

  test "should get edit" do
    get edit_deck_url(@deck)
    assert_response :success
  end

  class Unauthorized < self
    test "should not create deck" do
      assert_no_difference("Deck.count") do
        post decks_url, params: {deck: {raw: @deck.raw, title: @deck.title}}
      end
    end

    test "should not update deck" do
      old_deck = @deck.dup
      patch deck_url(@deck), params: {deck: {raw: "new raw content", title: "new title"}}
      assert_equal old_deck.raw, @deck.reload.raw
      assert_equal old_deck.title, @deck.reload.title
    end

    test "should not destroy deck" do
      assert_no_difference("Deck.count") do
        delete deck_url(@deck)
      end

      assert_redirected_to decks_url
    end
  end

  class Authorized < self
    setup do
      login(:one)
    end

    test "should create deck" do
      assert_difference("Deck.count") do
        post decks_url, params: {deck: {raw: @deck.raw, title: @deck.title}}
      end

      assert_redirected_to deck_url(Deck.last)
    end

    test "should update deck" do
      login(:one)
      patch deck_url(@deck), params: {deck: {raw: @deck.raw, title: @deck.title}}
      assert_redirected_to deck_url(@deck)
    end

    test "should destroy deck" do
      assert_difference("Deck.count", -1) do
        delete deck_url(@deck)
      end
    end

    def login(name)
      post "/sessions", params: {
        session: {
          email: users(name).email,
          password: "secret"
        }
      }
      assert_response :redirect
    end
  end
end
