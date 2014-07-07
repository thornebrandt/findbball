require 'spec_helper'

describe "Court pages" do
  
  subject { page }
  
  describe "profile page" do
    let(:court) { FactoryGirl.create(:court) }
    before { visit court_path(court) }
    
    it { should have_content(court.name) }
    it { should have_title(court.name) }
  end
end
