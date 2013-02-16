# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  up         :boolean
#

class Vote < ActiveRecord::Base
  attr_accessible :post_id, :up

  validates :user_id, :uniqueness => { :scope => :post_id }

  belongs_to :user
  belongs_to :post
  
end
