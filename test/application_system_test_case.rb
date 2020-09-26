require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def login(name)
    visit new_session_url
    fill_in "Email", with: users(name).email
    fill_in "Password", with: "secret"
    click_on "Login"
  end
end
