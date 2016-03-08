class BusinessCardsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  
  def index
    @businesscards = if params[:keywords]
                 BusinessCard.where('name ilike ?',"%#{params[:keywords]}%")
               else
                 []
               end

  end
  def show
    @businesscard = BusinessCard.find(params[:id])
  end

  def create
      @businesscard = BusinessCard.new(params.require(:businesscard).permit(:name,:addresses,:linkedin,:facebook,:twitter,:instagram,:pinterest,:user_id))
    @businesscard.save
    render 'show', status: 201
  end

  def update
    businesscard = BusinessCard.find(params[:id])
    businesscard.update_attributes(params.require(:businesscard).permit(:name,:addresses,:linkedin,:facebook,:twitter,:instagram,:pinterest,:user_id))
    head :no_content
  end

  def destroy
    businesscard = BusinessCard.find(params[:id])
    businesscard.destroy
    head :no_content
  end
end
