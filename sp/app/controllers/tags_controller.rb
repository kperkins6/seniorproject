class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
               Recipe.where('name ilike ?',"%#{params[:keywords]}%")
             else
               []
             end
  end
end
