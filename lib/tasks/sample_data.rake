namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_companies
  end
end

def make_users
  admin = User.create!(name: "Example User",
                       email: "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end


def make_companies
  Company.create!(symbol: "LCY", name: "Legacy Iron Ore")
  99.times do
    symbol = (0...3).map{65.+(rand(26)).chr}.join
    name = Faker::Name.last_name
    Company.create!(symbol: symbol,
                    name: name)
  end
end


