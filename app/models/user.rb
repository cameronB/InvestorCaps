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
  has_many :s_relationships, foreign_key: "s_follower_id", dependent: :destroy
  has_many :s_followed_users, through: :s_relationships, source: :s_followed
  has_many :s_reverse_relationships, foreign_key: "s_followed_id",
           class_name: "SRelationship",
           dependent: :destroy
  has_many :s_followers, through: :s_reverse_relationships, source: :s_follower

  #users can follow cpmpanies
  has_many :c_relationships, foreign_key: "c_follower_id", dependent: :destroy
  has_many :c_followed_companies, through: :c_relationships, source: :c_followed

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

  def s_following?(other_user)
    s_relationships.find_by_s_followed_id(other_user.id)
  end

  def s_follow!(other_user)
    s_relationships.create!(s_followed_id: other_user.id)
  end

  def s_unfollow!(other_user)
    s_relationships.find_by_s_followed_id(other_user.id).destroy
  end

  def c_following?(other_user)
    c_relationships.find_by_c_followed_id(other_user.id)
  end

  def c_follow!(other_user)
    c_relationships.create!(c_followed_id: other_user.id)
  end

  def c_unfollow!(other_user)
    c_relationships.find_by_c_followed_id(other_user.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
