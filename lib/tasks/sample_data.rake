namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    make_companies
    #make_posts
    #make_relationships
    #make_company_relationships
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

def make_posts
  users = User.all(limit: 6)
  50.times do
    url = "http://www.placeholder.com"
    title = Faker::Lorem.sentence(6)
    users.each { |user| user.posts.create!(url: url, title: title) }
  end
end

def make_companies
  Company.create!(symbol: "LCY", name: "Legacy Iron Ore")
  10.times do
    symbol = (0...3).map{65.+(rand(26)).chr}.join
    name = Faker::Name.last_name
    Company.create!(symbol: symbol,
                    name: name)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end


def make_company_relationships
  users = User.all
  user = users.first
  cfollowed_companies       = users[1..10]
  cfollowers                = users[2..10]
  cfollowed_companies.each { |cfollowed| user.cfollow!(cfollowed) }
  cfollowers.each          { |cfollower| cfollower.cfollow!(user)  }
end
