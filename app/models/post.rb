class Post < ActiveRecord::Base
  attr_accessible :url, :title
  belongs_to :user

  validates :user_id, presence: true
  #validates :url, presence: true, length: { maximum: 140 }
  validates :title, presence: true, length: { maximum: 150 }
  
  default_scope order: 'posts.created_at DESC'

end
