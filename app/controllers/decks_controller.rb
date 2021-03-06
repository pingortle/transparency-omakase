class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(deck_params)

    respond_to do |format|
      if @deck.valid?(:authorization) && @deck.save
        format.html { redirect_to @deck, notice: "Deck was successfully created." }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.valid?(:authorization) && @deck.update(deck_params)
        format.html { redirect_to @deck, notice: "Deck was successfully updated." }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    respond_to do |format|
      if @deck.valid?(:authorization) && @deck.destroy
        format.html { redirect_to decks_url, notice: "Deck was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to decks_url, alert: @deck.errors.full_messages.join(", ") }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deck
    @deck = Deck.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deck_params
    params.require(:deck).permit(:title, :raw)
  end
end
