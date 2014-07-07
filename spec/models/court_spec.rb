require 'spec_helper'

describe Court do
  
  let(:member) { FactoryGirl.create(:member) }
  before { @court = member.courts.build(name: "Lorem ipsum", address: "1408 Lorem Rd", member: @member) }
  
  subject { @court }
  
  it { should respond_to(:name) }
  it { should respond_to(:member_id) }
  its(:member) { should eq member }
  
  it { should be_valid }
  
  describe "when member_id is not present" do
    before { @court.member_id = nil }
    it { should_not be_valid }
  end
    
end