require 'spec_helper'

describe Court do
  
  let(:member) { FactoryGirl.create(:member) }
  before { @court = member.courts.build(name: "Courtem ipsum", address: "1408 Parkway Rd", member: @member) }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:member) }
  it { should respond_to(:member_id) }
  its(:member) { should eq member }
  
  it { should be_valid }
  
  describe "when member_id is not present" do
    before { @court.member_id = nil }
    it { should_not be_valid }
  end
  
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