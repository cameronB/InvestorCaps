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

require 'spec_helper'

describe SRelationship do

  let(:s_follower) { FactoryGirl.create(:user) }
  let(:s_followed) { FactoryGirl.create(:user) }
  let(:s_relationship) { s_follower.s_relationships.build(s_followed_id: s_followed.id) }

  subject { s_relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        SRelationship.new(s_follower_id: s_follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { should respond_to(:s_follower) }
    it { should respond_to(:s_followed) }
    its(:s_follower) { should == s_follower }
    its(:s_followed) { should == s_followed }
  end

  describe "when followed id is not present" do
    before { s_relationship.s_followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { s_relationship.s_follower_id = nil }
    it { should_not be_valid }
  end
end
