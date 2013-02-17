# == Schema Information
#
# Table name: company_relationships
#
#  id                  :integer          not null, primary key
#  company_follower_id :integer
#  company_followed_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class CompanyRelationship < ActiveRecord::Base
  attr_accessible :company_followed_id

  belongs_to :company_follower, class_name: "User"
  belongs_to :company_followed, class_name: "Company"

  validates :company_follower_id, presence: true
  validates :company_followed_id, presence: true

end
