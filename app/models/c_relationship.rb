# == Schema Information
#
# Table name: crelationships
#
#  id                  :integer          not null, primary key
#  c_follower_id :integer
#  c_followed_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class CRelationship < ActiveRecord::Base
  attr_accessible :c_followed_id

  belongs_to :c_follower, class_name: "User"
  belongs_to :c_followed, class_name: "Company"

  validates :c_follower_id, presence: true
  validates :c_followed_id, presence: true

end
