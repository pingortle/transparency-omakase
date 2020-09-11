class SpontaneousEventController < ApplicationController
  layout "spontaneous_events"

  def show
    @deck = Deck.find(params[:deck_id])
  end
end
