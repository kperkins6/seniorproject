class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
          Tag.where('name ilike ?',"%#{params[:keywords]}%")              # Tag.where('text')
             else
               []
             end
  end
end
