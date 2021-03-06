# == Schema Information
#
# Table name: comment_votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  up         :boolean
#

class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :up
  validates :user_id, :uniqueness => { :scope => :comment_id }

  belongs_to :user
  belongs_to :comment
  
end
