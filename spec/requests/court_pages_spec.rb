require 'spec_helper'

describe "Court pages" do
  
  subject { page }
  
  let(:member) { FactoryGirl.create(:member) }
  before { sign_in member }
  
  before { @court = member.courts.build(name: "HoopZone", location: "123 Fake St, Atlanta, GA 30067", website: "http://mylifeismetal.com",
                                         best_time: 6, best_time_ampm: "pm", best_day: "sunday",
                                         hours_open: 9, hours_open_ampm: "am", hours_closed: 10, hours_closed_ampm: "pm", skill_level: "1") }
  
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
  
  describe "add court page" do
    
    before { visit new_court_path }
    
    it { should have_css('div.add_court_map') }
    it { should have_field('address_search') }
    it { should have_field('Court Name') }
    it { should have_field('Competition Level') }
    it { should have_field('Best Time for a "pick-up" game')}
    it { should have_field('Accessible Hours') }
    it { should have_field('Court website link (if available)') }
    it { should have_field('Details/Review') }
  end
  
  describe "add court" do
    
    before { visit new_court_path }
    
    let(:submit) { "Add my court" }
    
    describe "with invalid information" do
      it "should not create a court" do
        expect { click_button submit}.not_to change(Court, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Court Name",       with: "Example Court"
        fill_in "address_search",    with: "foobar"
      end
      
      it "should create a court" do
        expect { click_button submit }.to change(Court, :count).by(1)
      end
    end
  end
end
