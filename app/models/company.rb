# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  symbol     :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  attr_accessible :name, :symbol
  before_save { self.symbol.upcase! }

  validates :symbol, presence: true, length: { maximum: 3 }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }

  #Companies have user followers but can not follow users or other companies
  has_many :posts, dependent: :destroy
  has_many :c_reverse_relationships, foreign_key: "c_followed_id",
           class_name:  "CRelationship",
           dependent:   :destroy
  has_many :c_followers, through: :c_reverse_relationships, source: :c_follower

  def to_param
    symbol
  end

end
