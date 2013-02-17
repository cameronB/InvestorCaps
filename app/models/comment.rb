# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
	attr_accessible :message, :user_id, :post_id
	
	validates :user_id, presence: true
	validates :post_id, presence: true
  validates :message, presence: true, length: { maximum: 500 }

	belongs_to :post
	belongs_to :user
	has_many :comment_votes


end
