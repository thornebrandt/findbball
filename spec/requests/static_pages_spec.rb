require 'spec_helper'

describe "Static Pages" do

	subject { page }

	context "Splash Page" do
		before { visit root_path }
		it { should have_selector("#splash") }
		it { should_not have_selector("#top") }
		it { should_not have_selector("#footer") }
	end
end
