namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_companies
    #make_posts
    #make_relationships
    #make_company_relationships
  end
end

def make_users
  admin = User.create!(username: "cam_cams",
                       email: "cameronbradley.git@gmail.com",
                       password: "test123")
  admin.toggle!(:admin)
  4.times do |n|
    username = Faker::Name.first_name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(username: username,
                 email: email,
                 password: password)
  end
end

def make_companies
  Company.create!(symbol: "LCY", name: "Legacy Iron Ore")
  4.times do
    symbol = (0...3).map{65.+(rand(26)).chr}.join
    name = Faker::Name.last_name
    Company.create!(symbol: symbol,
                    name: name)
  end
end

def make_posts
  users = User.all(limit: 6)
  50.times do
    symbol = "LCY"
    title = "Test Post Title"
    content = "Test Post Content"
    users.each { |user| user.posts.create!(symbol: symbol, title: title, content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  shareholder_followed_users = users[2..5]
  shareholder_followers      = users[3..5]
  shareholder_followed_users.each { |shareholder_followed| user.shareholder_follow!(shareholder_followed) }
  shareholder_followers.each      { |shareholder_follower| shareholder_follower.follow!(user) }
end


def make_company_relationships
  users = User.all
  user = users.first
  company_followed_companies       = users[1..5]
  company_followers                = users[2..5]
  company_followed_companies.each { |company_followed| user.company_follow!(company_followed) }
  company_followers.each          { |company_follower| company_follower.company_follow!(user)  }
end
