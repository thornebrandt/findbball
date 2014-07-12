require 'spec_helper'

describe CourtsController do

  integrate_views

  describe "GET 'edit'" do

    before(:each) do
      @court = FactoryGirl.create(:court)
    end
    
    it "should be successful" do
      get :edit, :id => @court
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @court
      response.should have_tag("title", /edit court/i)
    end
  end
end