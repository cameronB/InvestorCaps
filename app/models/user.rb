# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password
  has_secure_password

  has_many :post_votes
  has_many :comment_votes
  has_many :comments
  has_many :posts, dependent: :destroy

  #users can follow users / users are followed by users
  has_many :shareholder_relationships, foreign_key: "shareholder_follower_id", dependent: :destroy
  has_many :shareholder_followed_users, through: :shareholder_relationships, source: :shareholder_followed
  has_many :shareholder_reverse_relationships, foreign_key: "shareholder_followed_id",
           class_name: "ShareholderRelationship",
           dependent: :destroy
  has_many :shareholder_followers, through: :shareholder_reverse_relationships, source: :shareholder_follower

  #users can follow cpmpanies
  has_many :company_relationships, foreign_key: "cfollower_id", dependent: :destroy
  has_many :cfollowed_companies, through: :company_relationships, source: :cfollowed

  before_save { self.email.downcase! }
  before_save :create_remember_token

  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def to_param
    username
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def shareholder_following?(other_user)
    shareholder_relationships.find_by_shareholder_followed_id(other_user.id)
  end

  def shareholder_follow!(other_user)
    shareholder_relationships.create!(shareholder_followed_id: other_user.id)
  end

  def shareholder_unfollow!(other_user)
    shareholder_relationships.find_by_shareholder_followed_id(other_user.id).destroy
  end

  def cfollowing?(other_user)
    company_relationships.find_by_cfollowed_id(other_user.id)
  end

  def cfollow!(other_user)
    company_relationships.create!(cfollowed_id: other_user.id)
  end

  def cunfollow!(other_user)
    company_relationships.find_by_cfollowed_id(other_user.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
