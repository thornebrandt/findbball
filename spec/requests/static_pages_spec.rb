require 'spec_helper'

describe "Static Pages" do

	subject { page }

	shared_examples_for "complete layout" do
		it { should have_selector("#top") }
		it { should have_selector("#footer") }
		it { should have_title(full_title(page_title)) }
	end

	context "Home Page" do
		before { visit home_path }
		let(:page_title) { '' }
		it_should_behave_like "complete layout"
	end

	context "Splash Page" do
		before { visit root_path }
		it { should have_selector("#splash") }
		it { should_not have_selector("#top") }
		it { should_not have_selector("#footer") }
	end

end
