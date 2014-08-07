require 'date'
require 'faker'

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  
	factory :member do
		email
		birthdate Date.today
		password "knownAsPrince"
		password_confirmation "knownAsPrince"
	end
	
	factory :court do
	  name "Courtem ipsum"
	  location "1408 Parkway Rd, Atlanta, GA 30067"
	  lat Faker::Address.latitude
	  lng Faker::Address.longitude
	  website "http://mylifeismetal.com"
	  skill_level 3
	  pickup_time 10
	  pickup_am "pm"
	  pickup_day "Thursday"
	  open_time_1 6
	  open_am_1 "am"
	  open_time_2 11
	  open_am_2 "pm"
	  member
	end
	
	factory :review do
	  content "It's great!"
	  member
	  court
	end
end