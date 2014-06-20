require 'spec_helper'

describe "PlayerProfiles" do

	subject { page }

	describe "profile page" do
		let(:player) { FactoryGirl.create(:player) }
		before { visit player_path(player) }
		
		describe "sidebar left" do
		  it { should have_css(div.sidebar_left) }
		  it { should have_css(img.profile_pic) }
		  it { should have_css(div.friends_container) }
		  it { should have_css(div.teams_container) }
		  it { should have_css(div.reviews_container) }
		end
		
		describe "sidebar right" do
		  it { should have_css(div.sidebar_right) }
		  
		  context "when member has no friends" do
		    before {@current_player_has_friends = false }
		    it { should_not have_css(a.friend) }
		  end
		    
		  context "when member has friends" do
		    before {@current_player_has_friends = true }
		    it { should have_css(a.friend) }
		  end
		  it { should have_css(div.friend_feed_container) }
		  it { should have_css(div.events_container) }
		  it { should have_css(div.courts_container) }
		end
		
		describe "main content" do
		  it { should have_content(player.name) }
      it { should have_title(player.name) }
	   	it { should have_content(player.member_since) }
		  it { should have_css(table.history) }
		
	   	context "when member does not have schedule" do
	   	  before {@player_has_schedule = false}
	   	  it { should_not have_css(div.next_game) }
	   	end
		
	   	context "when member has schedule" do
	   	  before {@player_has_schedule = true}
	   	  it { should have_css(div.next_game) }
	   	end
		end
	end

	describe "signup page" do
		before { visit signup_path }
		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" }
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(Player, :count)
			end

			describe "after submission" do
				before { click_button submit }
				it { should have_title('Sign up') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Email", 			with: "dude@example.com"
				fill_in "Password", 		with: "password"
				fill_in "Confirmation", 	with: "password"
			end

			it "should create a user" do
				expect { click_button submit }.to change(Player, :count).by(1)
			end

			it "should have a valid email" do
				click_button submit
				newPlayer = Player.order("created_at").last
				newPlayer.email.should == "dude@example.com"
			end
		end
	end
end
