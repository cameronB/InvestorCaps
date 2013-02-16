# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  symbol     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  content    :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :symbol, :title, :content
  
  has_many :comments
  has_many :post_votes
  
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true
  validates :symbol, presence: true, length: { maximum: 3 }
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 500 }
  
  before_save :uppercase_symbol

  default_scope order: 'posts.created_at DESC'

  def self.from_users_followed_by(user)
    Post.find_by_sql("SELECT 'posts'.* 
                        FROM 'posts'
                        INNER JOIN companies on posts.symbol = companies.symbol
                        WHERE (user_id IN (SELECT followed_id FROM relationships WHERE follower_id = :user_id)) 
                        OR (companies.id IN (SELECT cfollowed_id from company_relationships WHERE cfollower_id = :user_id))
                        OR user_id = :user_id
                        ORDER BY posts.created_at DESC")
  end

  def uppercase_symbol
    self.symbol.upcase!
  end

end
