# == Schema Information
#
# Table name: shareholder_relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ShareholderRelationship < ActiveRecord::Base
  attr_accessible :shareholder_followed_id

  belongs_to :shareholder_follower, class_name: "User"
  belongs_to :shareholder_followed, class_name: "User"

  validates :shareholder_follower_id, presence: true
  validates :shareholder_followed_id, presence: true
end
