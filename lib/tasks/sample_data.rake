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
  followed_users = users[2..5]
  followers      = users[3..5]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end


def make_company_relationships
  users = User.all
  user = users.first
  cfollowed_companies       = users[1..5]
  cfollowers                = users[2..5]
  cfollowed_companies.each { |cfollowed| user.cfollow!(cfollowed) }
  cfollowers.each          { |cfollower| cfollower.cfollow!(user)  }
end
