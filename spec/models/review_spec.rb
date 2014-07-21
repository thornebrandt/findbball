require 'spec_helper'

describe Review do
  
  let(:member) { FactoryGirl.create(:member) }
  let(:court) { FactoryGirl.create(:court) }
  
  before do
    @review = Review.new(content: "It's great!", member_id: member.id, court_id: court.id)
  end
  
  subject { @review }
  
  it { should respond_to(:content) }
  it { should respond_to(:member_id) }
  it { should respond_to(:court_id) }
  
  it { should be_valid }
  
  describe "when member_id is not present" do
    before { @review.member_id = nil }
    it { should_not be_valid }
  end
end
