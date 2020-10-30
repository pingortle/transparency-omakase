class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :session

  def user=(user)
    super Visitor.wrap(user)
  end

  def session=(session)
    super(
      Session.wrap(session).tap do |session|
        self.user = session.authorization
      end
    )
  end

  module SimplyWrappable
    extend ActiveSupport::Concern

    class_methods do
      def wrap(candidate)
        return candidate if candidate.is_a? self
        new(candidate)
      end
    end
  end

  class Visitor < Struct.new(:identity)
    include Current::SimplyWrappable

    def signed_in?
      identity.present?
    end

    def is?(other)
      identity == other
    end
  end

  class Session < Struct.new(:raw)
    include Current::SimplyWrappable

    def revoke
      raw.delete(:authorization_sgid)
    end

    def authorize(identity)
      raw[:authorization_sgid] = identity.to_signed_global_id.to_s
    end

    def authorization
      @authorization ||= GlobalID::Locator.locate_signed(raw[:authorization_sgid])
    end
  end
end
