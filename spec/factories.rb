FactoryGirl.define do
	factory :member do
		email "artist@formerly.com"
		password "knownAsPrince"
		password_confirmation "knownAsPrince"
	end
	
	factory :court do
	  name "Courtem ipsum"
	  address "1408 Parkway Rd"
	end
end