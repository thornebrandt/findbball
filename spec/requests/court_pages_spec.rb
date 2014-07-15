require 'spec_helper'

describe "Court pages" do
  
  subject { page }
  
  describe "profile page", :skip => true do
    let(:member) { @member = FactoryGirl.create(:member) }
  
    before { @court = member.courts.build(name: "Hoopz", address: "123 Fake St", city: "Atlanta", state: "GA", zip: "30067",
                                          best_time: "6 to 8 Wednesdays", skill_level: "1") }
    before { visit court_path(@court) }
    # Need to adjust tests to sign in before creating a court.
    
    it { should have_content(court.name) }
    it { should have_content(court.address) }
    it { should have_title(court.name) }
    
    describe "sidebar left" do 
      it { should have_css('div.profile_pic_container') }
      it { should have_css('button.playToday') }
      it { should have_css('div.court_events_container') }
      it { should have_css('div.friends_container') }
    end
    
    describe "sidebar right" do
      it { should have_css('div.author_container') }
      it { should have_css('div.court_map') }
      it { should have_css('h4.milesAway') }
      it { should have_css('a.changeLocation') }
      it { should have_css('img.ad_right') }
    end
    
    describe "content" do
      it { should have_css('h2.courtName') }
      it { should have_css('a.courtWebsite') }
      it { should have_css('p.courtAddress') }
      it { should have_css('p.courtHours') }
      it { should have_css('div.courtDifficulty') }
      it { should have_css('p.courtPickUpGame') }
      it { should have_css('div.courtPhotos_container') }
      it { should have_css('div.courtVideos_container') }
      it { should have_css('div.reviewsContainer') }
    end
  end
  
  describe "add court page" do
    before { visit new_court_path }
    it { should have_content('Add a court') }
    it { should have_title(full_title('Add a court')) }
    it { should have_field('Name') }
    it { should have_field('Address') }
    it { should have_field('City') }
    it { should have_field('State') }
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
        fill_in "Name",       with: "Example Court"
        fill_in "Address",    with: "foobar"
        fill_in "City",       with: "Atlanta"
        fill_in "State",      with: "GA"
      end
      
      it "should create a court" do
        expect { click_button submit }.to change(Court, :count).by(1)
      end
    end
  end
end
