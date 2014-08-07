require 'spec_helper'

describe Court do
  
  before { @court = FactoryGirl.create(:court) }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:lat) }
  it { should respond_to(:lng) }
  it { should respond_to(:website) }
  
  it { should respond_to(:member_id) }
  it { should respond_to(:pickup_time) }
  it { should respond_to(:pickup_am) }
  it { should respond_to(:pickup_day) }
  it { should respond_to(:open_time_1) }
  it { should respond_to(:open_am_1)}
  it { should respond_to(:open_time_2) }
  it { should respond_to(:open_am_2) }
  it { should respond_to(:skill_level) }
  
  it { should respond_to(:member) }
  it { should respond_to(:reviews) }
  
  it { should be_valid }
  
  describe "with blank name" do
    before { @court.name = nil}
    it { should_not be_valid }
  end
  
  describe "with name that is too long" do
    before { @court.name = "a" * 71 }
    it { should_not be_valid }
  end
 
  describe "with blank location" do
    before { @court.location = nil}
    it { should_not be_valid }
  end
  
  describe "with location that is too long" do
    before { @court.location = "a" * 201 }
    it { should_not be_valid }
  end
    
end