require 'spec_helper'

describe Court do
  
  let(:member) { @member = FactoryGirl.create(:member) }
  
  before { @court = member.courts.build(name: "Hoopz", address: "123 Fake St", city: "Atlanta", state: "GA", zip: "30067",
                                        best_time: "6 to 8 Wednesdays", skill_level: "1") }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
  it { should respond_to(:country) }
  
  it { should respond_to(:member_id) }
  it { should respond_to(:best_time) }
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
 
  describe "with blank address" do
    before { @court.address = nil}
    it { should_not be_valid }
  end
  
  describe "with address that is too long" do
    before { @court.address = "a" * 96 }
    it { should_not be_valid }
  end
    
end