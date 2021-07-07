class User < ApplicationRecord
  has_secure_password

  validate(on: :authorization) do
    unless Current.user.signed_in?
      errors.add(:authorization, "must be signed in")
    end
    unless Current.user.is?(self)
      errors.add(:authorization, "must not change user")
    end
  end

  validates :login, presence: true, uniqueness: true, format: /[a-zA-Z0-9_]{3,}/

  def authority
    :mine
  end
end
