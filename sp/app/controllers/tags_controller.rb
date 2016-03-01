class TagsController < ApplicationController
  def index
      @tags = if params[:keywords]
               Tag.where("text = ?", params[:keywords])
              # Tag.where('text')
             else
               []
             end
  end
end
