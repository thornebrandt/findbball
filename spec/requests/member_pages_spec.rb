require 'spec_helper'
Rspec.configure do |c|
    c.filter_run_excluding :skip => true
end

describe "member pages: " do

    subject { page }

    describe "profile page", :skip => true do
        let(:member) { FactoryGirl.create(:member) }
        let(:court) { FactoryGirl.create(:courrt) }
        let(:review) { FacctoryGirl.create(:review) }
        before { visit member_path(member) }

        describe "sidebar left" do
            it { should have_css('div.sidebar_left') }
            it { should have_css('img.profile_pic') }
            it { should have_css('div.friends_container') }
            it { should have_css('div.teams_container') }
            it { should have_css('div.reviews_container') }
            it { should have_content(member.reviews.count) }
            it { should have_content(review.court) }
        end

        describe "sidebar right" do
            it { should have_css('div.sidebar_right') }
                context "when member has no friends" do
                before {@current_member_has_friends = false }
                it { should_not have_css('a.friend') }
            end
                context "when member has friends" do
                before {@current_member_has_friends = true }
                it { should have_css('a.friend') }
            end
                it { should have_css('div.friend_feed_container') }
                it { should have_css('div.member_events_container') }
                it { should have_css('div.courts_container') }
                it { should have_content(member.courts.count) }
                it { should have_content(court.name) }
                it { should have_content(court.location) }
        end

        describe "main content" do
            it { should have_content(member.name) }
            it { should have_title(member.name) }
            it { should have_content(member.member_since) }
            it { should have_css(table.history) }

            context "when member does not have schedule" do
                before {@member_has_schedule = false}
                it { should_not have_css('div.next_game') }
            end

            context "when member has schedule" do
                before {@member_has_schedule = true}
                it { should have_css('div.next_game') }
            end
        end
    end

    describe "signup page" do
        before { visit signup_path }
        it { should have_content('SIGN UP') }
        it { should have_title(full_title('Sign up')) }
    end

    describe "signup" do
        before { visit signup_path }
        let(:submit) { "Create Account" }
        describe "with invalid information" do
            it "should not create a member" do
                expect { click_button submit }.not_to change(Member, :count)
            end

            describe "after submission" do
                before { click_button submit }
                it { should have_title('Sign up') }
                it { should have_content('Could not create member') }
            end
        end

        describe "with valid information" do
            before do
                fill_in "Email",                with: "dude@example.com"
                fill_in "Password",             with: "password"
                fill_in "Confirm Password",     with: "password"
            end

            it "should create a member" do
                expect { click_button submit }.to change(Member, :count).by(1)
            end

            it "should have a valid email" do
                click_button submit
                newMember = Member.order("created_at").last
                newMember.email.should == "dude@example.com"
            end
        end
    end
end
