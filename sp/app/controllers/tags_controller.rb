class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
               Tag.where('text ilike ?',"%#{params[:keywords]}%")
             else
               []
             end
  end
end
