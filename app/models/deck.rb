class Deck < ApplicationRecord
  def slides
    raw.split(/---|(\r?\n){2,}/).map(&:chomp).reject(&:empty?)
  end
end
