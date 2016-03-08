class TagsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
      @tags = if params[:keywords]
          Tag.where('text ilike ?',"%#{params[:keywords]}%")              # Tag.where('text')
             else
               []
             end
  end
  def show
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(params.require(:tag).permit(:text,:hits,:user_id,:businesscard_id))
    @tag.save
    render 'show', status: 201
  end

  def update
    tag = Tag.find(params[:id])
    tag.update_attributes(params.require(:tag).permit(:text,:hits,:user_id,:businesscard_id))
    head :no_content
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content
  end
end
