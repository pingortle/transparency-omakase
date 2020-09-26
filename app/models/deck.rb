class Deck < ApplicationRecord
  validate(on: :authorization) do
    unless Current.user.signed_in?
      errors.add(:authorization, "must be signed in")
    end
  end

  def slides
    raw.split(/---|(\r?\n){2,}/).map(&:chomp).reject(&:empty?)
  end
end
