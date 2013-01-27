class Comment < ActiveRecord::Base
	attr_accessible :message, :user_id, :post_id
	
	validates :user_id, presence: true
	validates :post_id, presence: true
    validates :message, presence: true, length: { maximum: 500 }

	belongs_to :post
	belongs_to :user
end
