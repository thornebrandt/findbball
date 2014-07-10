require 'spec_helper'

describe Court do
  
  before { @court = Court.new(name: "Courtem ipsum", address: "1408 Parkway Rd", member_id: nil) }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:member_id) }
  
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