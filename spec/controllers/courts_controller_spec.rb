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
  end
end