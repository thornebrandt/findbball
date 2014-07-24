require 'date'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_members
    make_courts
    # make_reviews
  end
end

def make_members
  Member.create!(name: "Admin",
                 email: "admin@findbball.com",
                 password: "hoopz",
                 password_confirmation: "hoopz",
                 birthdate: Date.today)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+300}@railstutorial.org"
    password  = "password"
    Member.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password,
                 birthdate: Date.today )
  end
end

def make_courts
  members = Member.all(limit: 6)
  50.times do
    name = Faker::Company.name
    location = Faker::Address.street_address
    website = Faker::Internet.url
    skill_level = 3
    pickup_time = Faker::Number.digit
    pickup_day = "Sunday" # How to make random days of week?
    pickup_am = "am"
    open_time_1 = Faker::Number.digit
    open_am_1 = "am"
    open_time_2 = Faker::Number.digit
    open_am_2 = "pm"
    members.each { |member| member.courts.create!(name: name,
                  location: location, website: website, skill_level: skill_level,
                  pickup_time: pickup_time, pickup_day: pickup_day,
                  pickup_am: pickup_am, open_time_1: open_time_1,
                  open_am_1: open_am_1, open_time_2: open_time_2,
                  open_am_2: open_am_2) }
  end
end