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

require 'spec_helper'

describe User do

  before do
    @user = User.new(username: "Example User", email: "user@example.com", password: "foobar1234")
  end

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:admin) }
  it { should respond_to(:posts) }
  it { should respond_to(:feed) }
  it { should respond_to(:c_relationships) }
  it { should respond_to(:s_relationships) }
  it { should respond_to(:s_reverse_relationships) }
  it { should respond_to(:s_followed_users) }
  it { should respond_to(:s_followers) }
  it { should respond_to(:s_following?) }
  it { should respond_to(:s_follow!) }
  it { should respond_to(:s_unfollow!) }

  it { should be_valid }
  it { should_not be_admin }

  describe "post associations" do

    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right posts in the right order" do
      @user.posts.should == [newer_post, older_post]
    end
  end

  describe "accessible attributes" do
    it "should not allow access to admin" do
      expect do
        User.new(admin: true)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.s_follow!(other_user)
    end

    it { should be_s_following(other_user) }
    its(:s_followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:s_followers) { should include(@user) }
    end

    describe "and unfollowing" do
      before { @user.s_unfollow!(other_user) }

      it { should_not be_s_following(other_user) }
      its(:s_followed_users) { should_not include(other_user) }
    end
  end

  describe "users can follow a company" do
    let(:other_company) { FactoryGirl.create(:company) }
    before do
      @user.save
      @user.c_follow!(other_company)
  end

  it { should be_c_following(other_company) }
  its(:c_followed_companies) { should include(other_company) }

   describe "Check that Company is now being followed by the user" do
      subject { other_company }
      its(:c_followers) {should include(@user) }
   end

    describe "user can unfollow a company" do
      before { @user.c_unfollow!(other_company) }

      it { should_not be_c_following(other_company) }
      its(:c_followed_companies) { should_not include(other_company) }
    end
  end
end
