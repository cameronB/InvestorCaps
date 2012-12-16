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
                        FROM posts 
                        INNER JOIN companies ON posts.symbol=companies.symbol
                        WHERE (companies.id IN (SELECT cfollowed_id FROM company_relationships
                        WHERE cfollowed_id = '4') OR companies.id = '4') 
                        OR (user_id IN (SELECT followed_id FROM relationships
                        WHERE follower_id = 1) OR user_id = 1)
                        ORDER BY posts.created_at DESC LIMIT 30 OFFSET 0")
  end
end
