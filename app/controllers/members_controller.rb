class MembersController < ApplicationController
	def show
		@member = Member.find(params["id"])
	end

    def show_test(id)
        @noHeaderFooter = true
        @member = Member.find(id)
    end

	def new
		@noHeaderFooter = true
		@member = Member.new
	end

    def edit
        @member = Member.find(params[:id])
    end

    def update_field()
        @member = Member.find_by_id(params[:id])
        puts "params[:member][:full_name]"
        puts params[:member][:full_name]
        if @member.update_attribute :full_name, params[:member][:full_name]
            flash[:success] = "Profile updated"
            #redirect_to @member
            redirect_to show_test(params[:id])
        else
            render 'show'
        end
    end

	def create
		@member = Member.new(member_params)
		if @member.save
			flash[:success] = "Welcome to Findbball"
			redirect_to @member
		else
			@noHeaderFooter = true
			flash[:error] = "Could not create member."
			render 'new'
		end
	end

	private
		def member_params
				params.require(:member).permit( :name,
                                                :email,
                                                :password,
                                                :password_confirmation,
                                                :full_name
                                                )
		end
end
