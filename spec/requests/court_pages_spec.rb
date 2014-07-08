require 'spec_helper'

describe "Court pages" do
  
  subject { page }
  
  describe "profile page" do
    let(:court) { FactoryGirl.create(:court) }
    before { visit court_path(court) }
    
    it { should have_content(court.name) }
    it { should have_content(court.address) }
    it { should have_title(court.name) }
  end
  
  describe "add court page" do
    before { visit addcourt_path }
    it { should have_content('Add a court') }
    it { should have_title(full_title('Add a court')) }
  end
  
  describe "add court" do
    
    before { visit addcourt_path }
    
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
      end
      
      it "should create a court" do
        expect { click_button submit }.to change(Court, :count).by(1)
      end
    end
  end
end
