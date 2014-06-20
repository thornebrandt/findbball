require 'spec_helper'

describe "AuthenticationPages" do
  describe "Authentication" do
  	subject { page }

  	describe "signin" do
  		before { visit signin_path }
  		it { should have_content('Sign in') }
  		it { should have_title('Sign in') }

  		describe "with valid information" do
  			let(:member) { FactoryGirl.create(:member) } 
  			before do
  				fill_in "Email", with: player.email.upcase
  				fill_in "Password", with: player.password
  				click_button "Sign in"
  			end

  			it { should have_selector('div#signed_in') }
  			it { should have_link('Sign out', href: signout_path) }
  			it { should_not have_link('Sign in', href: signin_path) }
  		end

  		describe "with invalid information" do
  			before { click_button "Sign in" }
  			it { should have_selector('div.alert.alert-error') }
  		end

  		describe "after visiting another page" do
  			before { click_link "Home" }
  			it { should_not have_seletor('div.alert.alert.error') }
  		end
  	end
  end
end
