class Session
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :password, :string

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
end
