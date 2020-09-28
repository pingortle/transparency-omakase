require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def login(name)
    visit new_session_url
    fill_in "Login", with: users(name).login
    fill_in "Password", with: "secret"
    click_on "Login"
  end
end
