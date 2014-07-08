FactoryGirl.define do
	factory :member do
		email "artist@formerly.com"
		password "knownAsPrince"
		password_confirmation "knownAsPrince"
	end
	
	# Rails Tutorial never defines microposts seperately in the factories.rb file - wonder if it's worth doing.
	factory :court do
	  name "Courtem ipsum"
	  address "1408 Parkway Rd"
	  member
	end
end