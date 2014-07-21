require 'spec_helper'

describe Review do
  
  let(:member) { FactoryGirl.create(:member) }
  let(:court) { FactoryGirl.create(:court) }
  
  before {@review = member.reviews.build(content: "It's great!", court: court) }
  
  subject { @review }
  
  it { should respond_to(:content) }
  it { should respond_to(:member_id) }
  it { should respond_to(:court_id) }
  
  it { should respond_to(:member) }
  its(:member) { should eq member }
  
  it { should be_valid }
  
  describe "when member_id is not present" do
    before { @review.member_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @review.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @review.content = "a" * 1001 }
    it { should_not be_valid }
  end
end
