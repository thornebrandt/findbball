require 'spec_helper'

describe "Court pages" do
  
  subject { page }
  
  before { @court = FactoryGirl.create(:court) }
  before { sign_in @court.member }
  
  describe "profile page", :skip => true do

    before { visit court_path(@court) }
    
    describe "sidebar left" do 
      it { should have_css('div.profile_pic_container') }
      it { should have_css('button.playToday') }
      it { should have_css('div.court_events_container') }
      it { should have_css('div.friends_container') }
    end
    
    describe "sidebar right" do
      it { should have_css('div.author_container') }
      it { should have_content( court.member ) }
      it { should have_css('div.court_map') }
      it { should have_css('h4.milesAway') }
      it { should have_css('a.changeLocation') }
      it { should have_css('img.ad_right') }
    end
    
    describe "content" do
      it { should have_css('h2.courtName') }
      it { should have_content(court.name) }
      it { should have_css('a.courtWebsite') }
      it { should have_css('p.courtAddress') }
      it { should have_content(court.location) }
      it { should have_css('p.courtHours') }
      it { should have_css('div.courtDifficulty') }
      it { should have_content(court.skill_level) }
      it { should have_css('p.courtPickUpGame') }
      it { should have_content(court.best_time) }
      it { should have_css('div.courtPhotos_container') }
      it { should have_css('div.courtVideos_container') }
      it { should have_css('div.reviewsContainer') }
    end
  end
  
  describe "add court page", :skip => true do
    
    before { visit new_court_path }
    
    it { should have_css('div.add_court_map') }
    it { should have_field('address_search') }
    it { should have_field('name') }
    it { should have_field('competitionLevel') }
    it { should have_field('pickupDay') }
    it { should have_field('pickupTime') }
    it { should have_field('pickupAM') }
    it { should have_field('openTime1') }
    it { should have_field('openAM1') }
    it { should have_field('openTime2') }
    it { should have_field('openAM2') }
    it { should have_field('reviewDetails') }
  end
  
  describe "add court" do
    
    before { visit new_court_path }
    
    
    let(:submit) { "submit_court" }
    
    describe "with invalid information" do
      it "should not create a court" do
        expect { click_button submit}.not_to change(Court, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "name",                    with: "Example Court"
        fill_in "address_search",          with: "123 Fake St, Marietta, GA 30327"
        select "Difficult",                from: "competitionLevel"
        select "Thursday",                 from: "pickupDay"
        select "10:00",                    from: "pickupTime"
        select "PM",                       from: "pickupAM"
        select "1:00",                     from: "openTime1"
        select "PM",                       from: "openAM1"
        select "3:00",                     from: "openTime2"
        select "PM",                       from: "openAM2"
      end
      
      it "should create a court" do
        expect { click_button submit }.to change(Court, :count).by(1)
      end
    end
  end
end
