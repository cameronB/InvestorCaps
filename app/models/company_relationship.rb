# == Schema Information
#
# Table name: company_relationships
#
#  id           :integer          not null, primary key
#  cfollower_id :integer
#  cfollowed_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CompanyRelationship < ActiveRecord::Base
  attr_accessible :cfollowed_id

  belongs_to :cfollower, class_name: "User"
  belongs_to :cfollowed, class_name: "Company"

  validates :cfollower_id, presence: true
  validates :cfollowed_id, presence: true

end
