class BusinessCardsController < ApplicationController
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
    @businesscard = BusinessCard.new(params.require(:businesscard).permit(:name,:address))
    @businesscard.save
    render 'show', status: 201
  end

  def update
    businesscard = BusinessCard.find(params[:id])
    businesscard.update_attributes(params.require(:businesscard).permit(:name,:address))
    head :no_content
  end

  def destroy
    businesscard = BusinessCard.find(params[:id])
    businesscard.destroy
    head :no_content
  end
end
