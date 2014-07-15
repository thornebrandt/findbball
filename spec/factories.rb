FactoryGirl.define do
	factory :member do
		email "artist@formerly.com"
		password "knownAsPrince"
		password_confirmation "knownAsPrince"
	end
	
	factory :court do
	  name "Courtem ipsum"
	  address "1408 Parkway Rd"
	  city "Atlanta"
	  state "GA"
	  zip "30067"
	  country "United States"
	  skill_level 3
	  best_time "Thursdays 10pm to 12am"
	  member
	end
end