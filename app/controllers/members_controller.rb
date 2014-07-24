class MembersController < ApplicationController
	def show
		@member = Member.find(params["id"])
		@courts = @member.courts
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
        puts "eddddiiittttt"
    end

    def update
        puts "calling update"
        @member = Member.find(params[:id])
        if params[:member][:birthdate]
            new_birthdate = Chronic.parse(params[:member][:birthdate]).strftime('%Y-%m-%d');
            params[:member][:birthdate] = new_birthdate
            puts "params[:member]"
            puts params[:member]
        end
        respond_to do |format|
            if @member.update_attributes(member_params)
                format.html { redirect_to(@member, :notice => 'User was successfully updated.') }
                format.json do
                    respond_with_bip(@member)
                end
            end
        end
    end


	def create
		@member = Member.new(bip_params)
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
        def bip_params
            params.require(:member).permit(:name)
        end


		def member_params
			params.require(:member).permit( :name,
                                            :email,
                                            :password,
                                            :password_confirmation,
                                            :full_name,
                                            :general_location,
                                            :nationality,
                                            :birthdate,
                                            :slogan,
                                            :plays_basketball,
                                            :skill_level,
                                            :position,
                                            :organized,
                                            :favorite_player,
                                            :about
                                        )
		end

end
