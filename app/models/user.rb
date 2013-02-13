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

  has_many :votes
  has_many :comments
  has_many :posts, dependent: :destroy

  #users can follow users / users are followed by users
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
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
