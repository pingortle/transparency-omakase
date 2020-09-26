class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def user=(user)
    super Visitor.new(User.find_by(id: user))
  end

  class Visitor
    def initialize(user)
      @user = user
    end

    def signed_in?
      @user.present?
    end
  end
end
