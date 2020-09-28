class Session
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :login, :string
  attribute :password, :string

  validates_presence_of :login, :password

  def self.wrap(user)
    new(login: user.login, password: user.password)
  end
end
