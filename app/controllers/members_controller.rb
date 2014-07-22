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
        puts "eddddiiittttt"
    end

    def update
        @member = Member.find(params[:id])
        if params[:member][:birthdate]
            new_birthdate = Chronic.parse(params[:member][:birthdate]).strftime('%Y-%m-%d');
            params[:member][:birthdate] = new_birthdate
        end
        respond_to do |format|
            puts "what da format"
            puts @member.inspect
            if @member.update_attributes(member_params)
                # format.html { redirect_to(@member, :notice => 'User was successfully updated.') }
                format.json do
                    puts "a json format"
                    puts @member.inspect
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
