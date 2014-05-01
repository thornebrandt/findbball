require 'spec_helper'

describe "Static pages" do
	context "Home page" do
		it "should have content 'Findbball'" do
			visit '/static_pages/home'
			expect(page).to have_content('Findbball.com')
		end
	end
end
