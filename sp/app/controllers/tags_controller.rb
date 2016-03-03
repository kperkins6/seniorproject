class TagsController < ApplicationController
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
end
