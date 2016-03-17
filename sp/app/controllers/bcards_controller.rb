class BcardsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        @bcards = if params[:keywords]
        Bcard.where('name ilike ?',"%#{params[:keywords]}%")              # Bcard.where('description')
        else
        []
    end
end
def show
    @bcard = Bcard.find(params[:id])
	@tagcard = Tagcard.find_by(user_id: current_user.id, bcard_id: @bcard.id).first_or_initialize
	@tags = @tagcard.tags
	if @tags == []
		@tags << Tag.find_by(text: "Create some tags!")
	end
	@tagcard.save!
end

def create
    @bcard = Bcard.new(params.require(:bcard).permit(:name,:address,:linkedin,:facebook,:twitter,:instagram,:pinterest,:user_id))
    @bcard.save
    render 'show', status: 201
end

def update
    bcard = Bcard.find(params[:id])
    bcard.update_attributes(params.require(:bcard).permit(:name,:address,:linkedin,:facebook,:twitter,:instagram,:pinterest,:user_id))
    head :no_content
end

def destroy
    bcard = Bcard.find(params[:id])
    bcard.destroy
    head :no_content
end
end
