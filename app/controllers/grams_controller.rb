class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
	
	def new
		@gram = Gram.new
	end

	def index
	end

  def show 
    if @gram = Gram.find_by_id(params[:id]).blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end


  def create
    @gram = Gram.create(gram_params.merge(user: current_user))
    if @gram.valid?
      redirect_to root_path  
    else
      render :new, status: :unprocessable_entity
    end
  end


  def gram_params
    params.require(:gram).permit(:message)
  end

end
