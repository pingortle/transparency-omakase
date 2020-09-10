class SpontaneousEventController < ApplicationController
  def show
    @deck = Deck.find(params[:deck_id])
  end
end
