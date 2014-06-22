class MembersController < ApplicationController
  def show
  	@member = Member.find(params["id"])
  end

  def new
    @noHeaderFooter = true
  	@member = Member.new
  end

  def create
  	@member = Member.new(player_params)
  	if @member.save
  		flash[:success] = "Welcome to Findbball"
  		redirect_to @member
  	else
  		render 'new'
  	end
  end

  private

  	def member_params
  		params.require(:member).permit(:name, :email, :password, :password_confirmation)
  	end


end
