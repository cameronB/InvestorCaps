class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :up

  validates :user_id, :uniqueness => { :scope => :comment_id }

  belongs_to :user
  belongs_to :comment
  
end
