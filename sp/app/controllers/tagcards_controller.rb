class TagcardsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
      @tagcards = if params[:keywords]
          Tagcard.where('user_id ilike ?',"%#{params[:keywords]}%")              # Tagcard.where('text')
             else
               []
             end
  end
  def show
    @tagcard = Tagcard.find(params[:id])
  end

  def create
    @tagcard = Tagcard.new(params.require(:tagcard).permit(:user_id,:businesscard_id))
    @tagcard.save
    render 'show', status: 201
  end

  def update
    tagcard = Tagcard.find(params[:id])
    tagcard.update_attributes(params.require(:tagcard).permit(:user_id,:businesscard_id))
    head :no_content
  end

  def destroy
    tagcard = Tagcard.find(params[:id])
    tagcard.destroy
    head :no_content
  end
end
