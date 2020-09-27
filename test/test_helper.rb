ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login(name = nil, model: nil, password: "secret")
    who = model || users(name)
    post "/sessions", params: {
      session: {
        email: who.email,
        password: password
      }
    }
    assert_response :redirect
  end
end
