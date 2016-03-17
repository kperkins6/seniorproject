class HomeController < ApplicationController
  def index
     @myCard = Bcard.find(current_user.bcard_id)
  end
end
