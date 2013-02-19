# == Schema Information
#
# Table name: srelationships
#
#  id                      :integer          not null, primary key
#  s_follower_id :integer
#  s_followed_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class SRelationship < ActiveRecord::Base
  attr_accessible :s_followed_id

  belongs_to :s_follower, class_name: "User"
  belongs_to :s_followed, class_name: "User"

  validates :s_follower_id, presence: true
  validates :s_followed_id, presence: true
end
