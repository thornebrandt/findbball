require 'spec_helper'

describe Member do

	before { @member = FactoryGirl.create(:member) }

	subject { @member }


	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:courts) }
	it { should respond_to(:reviews) }
    it { should respond_to(:general_location) }
    it { should respond_to(:full_name) }
	it { should be_valid }

	describe "when email is not present" do
		before { @member.email = ""}
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
	   	it "should be invalid" do
	     	addresses = %w[member@foo,com member_at_foo.org example.member@foo.
	                    foo@bar_baz.com foo@bar+baz.com]
	     	addresses.each do |invalid_address|
	       	@member.email = invalid_address
	       	expect(@member).not_to be_valid
	    	end
	   	end
	end

	describe "when email format is valid" do
	   	it "should be valid" do
	     	addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	     	addresses.each do |valid_address|
	       	@member.email = valid_address
	       	expect(@member).to be_valid
	     	end
	   	end
	end

	describe "when email address is already taken" do
		before do
			member_with_same_email = @member.dup
			member_with_same_email.email = @member.email.upcase
			member_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "an email address with mixed case" do
		let(:mixed_case_email) { 'mIxEdEmaIl@example.com' }
		it "should be saved as lowercase" do
			@member.email = mixed_case_email
			@member.save
			expect(@member.reload.email).to eq mixed_case_email.downcase
		end
	end


	describe "return value of authenticate method" do
		before { @member.save }
		let(:found_member) { Member.find_by(email: @member.email) }

		describe "with valid password" do
			it { should eq found_member.authenticate(@member.password) }
		end

		describe "with invalid password" do
			let(:wrong_password_member) { found_member.authenticate("luckyGuess") }
			it { should_not eq wrong_password_member }
			specify { expect(wrong_password_member).to be_false }
		end

		describe "with a password that is too short" do
			before { @member.password = @member.password_confirmation = "a" * 5 }
			it { should be_invalid }
		end

	end


end
