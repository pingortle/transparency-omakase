class Deck < ApplicationRecord
  def slides
    raw.split(/---/)
  end
end
