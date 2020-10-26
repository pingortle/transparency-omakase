require_relative "boot"

require "rails/all"
require "omniauth-cognito-idp"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TransparencyOmakase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.assets false
    end

    config.middleware.use OmniAuth::Builder do
      provider :developer if Rails.env.development?
      provider OmniAuth::Strategies::CognitoIdP,
        ENV["COGNITO_CLIENT_ID"],
        ENV["COGNITO_CLIENT_SECRET"],
        client_options: {
          site: ENV["COGNITO_USER_POOL_SITE"]
        },
        scope: "email openid aws.cognito.signin.user.admin profile",
        user_pool_id: ENV["COGNITO_USER_POOL_ID"],
        aws_region: ENV["AWS_REGION"]
    end
  end
end
