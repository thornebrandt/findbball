require 'spec_helper'

describe Court do
  
  let(:member) { FactoryGirl.create(:member) }
  before { @court = member.courts.build(name: "HoopZone", location: "123 Fake St, Atlanta, GA 30067", website: "http://mylifeismetal.com",
                                         best_time: 6, best_time_ampm: "pm", best_day: "sunday",
                                         hours_open: 9, hours_open_ampm: "am", hours_closed: 10, hours_closed_ampm: "pm", skill_level: "1") }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:location) }
  it { should respond_to(:website) }
  
  it { should respond_to(:member_id) }
  it { should respond_to(:best_time) }
  it { should respond_to(:best_time_ampm) }
  it { should respond_to(:best_day) }
  it { should respond_to(:hours_open) }
  it { should respond_to(:hours_open_ampm)}
  it { should respond_to(:hours_closed) }
  it { should respond_to(:hours_closed_ampm) }
  it { should respond_to(:skill_level) }
  
  it { should respond_to(:member) }
  its(:member) { should eq member }
  
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