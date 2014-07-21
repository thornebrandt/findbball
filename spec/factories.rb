FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  
	factory :member do
		email
		password "knownAsPrince"
		password_confirmation "knownAsPrince"
	end
	
	factory :court do
	  name "Courtem ipsum"
	  location "1408 Parkway Rd, Atlanta, GA 30067"
	  website "http://mylifeismetal.com"
	  skill_level 3
	  best_time 10
	  best_time_ampm "pm"
	  best_day "Thursday"
	  hours_open 6
	  hours_open_ampm "am"
	  hours_closed 11
	  hours_closed_ampm "pm"
	  member
	end
	
	factory :review do
	  content "It's great!"
	  member
	  court
	end
end