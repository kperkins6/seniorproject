class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
               Tag.where("text IN ?", params[:keywords])
              # Tag.where('text')
             else
               []
             end
  end
end
