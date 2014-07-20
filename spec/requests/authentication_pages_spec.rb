require 'spec_helper'

describe "AuthenticationPages" do
  describe "Authentication" do
  	subject { page }

  	describe "Login" do
  		before { visit home_path }
  		it { should have_content('Login') }

  		describe "with valid information" do
  			let(:member) { FactoryGirl.create(:member) }
  			before do
  				fill_in "Email", with: member.email.upcase
  				fill_in "Password", with: member.password
  				click_button "Sign in"
  			end

  			it { should have_link('Logout', href: signout_path) }
            it { should have_selector('#logged_in') }
  			it { should_not have_link('Login') }
  		end

  		describe "with invalid information" do
  			before { click_button "Sign in" }
  			it { should have_selector('div.alert.alert-error') }
  		end

  		describe "after visiting another page" do
  			before { click_link "logo" }
  			it { should_not have_selector('div.alert.alert.error') }
  		end
  	end
  end
end
