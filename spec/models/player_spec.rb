require 'spec_helper'

describe Player do

	before do
		@player = Player.new(
						email: "freddy@elmstreet.com",
						password: "inYourDreams",
						password_confirmation: "inYourDreams"
					)
	end

	subject { @player }


	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should be_valid } 

	describe "when email is not present" do 
		before { @player.email = ""}
		it { should_not be_valid } 
	end

	describe "when email format is invalid" do
	   	it "should be invalid" do
	     	addresses = %w[player@foo,com player_at_foo.org example.player@foo.
	                    foo@bar_baz.com foo@bar+baz.com]
	     	addresses.each do |invalid_address|
	       	@player.email = invalid_address
	       	expect(@player).not_to be_valid
	    	end
	   	end
	end

	describe "when email format is valid" do
	   	it "should be valid" do
	     	addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	     	addresses.each do |valid_address|
	       	@player.email = valid_address
	       	expect(@player).to be_valid
	     	end
	   	end
	end

	describe "when email address is already taken" do
		before do
			player_with_same_email = @player.dup
			player_with_same_email.email = @player.email.upcase
			player_with_same_email.save
		end

		it { should_not be_valid } 
	end

	describe "an email address with mixed case" do
		let(:mixed_case_email) { 'mIxEdEmaIl@example.com' }
		it "should be saved as lowercase" do
			@player.email = mixed_case_email
			@player.save
			expect(@player.reload.email).to eq mixed_case_email.downcase
		end
	end



	describe "return value of authenticate method" do
		before { @player.save }
		let(:found_player) { Player.find_by(email: @player.email) }

		describe "with valid password" do
			it { should eq found_player.authenticate(@player.password) }
		end

		describe "with invalid password" do
			let(:wrong_password_player) { found_player.authenticate("luckyGuess") }
			it { should_not eq wrong_password_player }
			specify { expect(wrong_password_player).to be_false }
		end

		describe "with a password that is too short" do 
			before { @player.password = @player.password_confirmation = "a" * 5 }
			it { should be_invalid }
		end

	end


end
