class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
               Tag.where('name ilike ?',"%#{params[:keywords]}%")
             else
               []
             end
  end
end
