class Post < ActiveRecord::Base
  attr_accessible :symbol, :title, :content
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true
  validates :symbol, presence: true, length: { maximum: 3 }
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 500 }
  
  default_scope order: 'posts.created_at DESC'

  def self.from_users_followed_by(user)
    Post.find_by_sql("SELECT *
                      FROM users
                      INNER JOIN company_relationships ON users.id=company_relationships.cfollower_id
                      INNER JOIN companies ON company_relationships.cfollowed_id=companies.id
                      INNER JOIN posts ON companies.symbol = posts.symbol
                      WHERE (users.id IN (SELECT cfollower_id from company_relationships
                      WHERE cfollower_id = :user_id) OR users.id = :user_id)
                      ORDER BY posts.created_at DESC")
  end
end
