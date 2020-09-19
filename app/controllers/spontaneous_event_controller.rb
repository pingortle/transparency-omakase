class SpontaneousEventController < ApplicationController
  def show
    @title = "Presenting"
    @hide_header = true
    @presenting = true
    @deck = Deck.find(params[:deck_id])
  end
end
