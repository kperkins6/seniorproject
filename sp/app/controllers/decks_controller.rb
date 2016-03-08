class DecksController < ApplicationController
  def index
      @decks = if params[:keywords]
          Deck.where('text ilike ?',"%#{params[:keywords]}%")              # Deck.where('text')
             else
               []
             end
  end
  def show
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.new(params.require(:deck).permit(:description,:user_id))
    @deck.save
    render 'show', status: 201
  end

  def update
    deck = Deck.find(params[:id])
    deck.update_attributes(params.require(:deck).permit(:description,:user_id))
    head :no_content
  end

  def destroy
    deck = Deck.find(params[:id])
    deck.destroy
    head :no_content
  end
end
