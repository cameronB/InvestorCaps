# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  symbol     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  content    :string(255)
#

require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before { @post = user.posts.build(symbol: "LCY", title: "Annoucment out!", content: "woot annoucment out guys!") }

  subject { @post }

  it { should respond_to(:symbol) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "with blank title" do
  	before { @post.title = " " }
  	it { should_not be_valid }
  end

  describe "with title that is too long" do
  	before { @post.title = "a" * 151 }
  	it { should_not be_valid }
  end
end
