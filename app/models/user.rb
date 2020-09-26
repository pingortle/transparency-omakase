class User < ApplicationRecord
  has_secure_password

  validate(on: :authorization) do
    unless Current.user.signed_in?
      errors.add(:authorization, "must be signed in")
    end
  end

  validates :email, presence: true, uniqueness: true
end
