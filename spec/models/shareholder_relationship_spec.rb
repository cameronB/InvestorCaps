# == Schema Information
#
# Table name: shareholder_relationships
#
#  id                      :integer          not null, primary key
#  shareholder_follower_id :integer
#  shareholder_followed_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'spec_helper'

describe ShareholderRelationship do

  let(:shareholder_follower) { FactoryGirl.create(:user) }
  let(:shareholder_followed) { FactoryGirl.create(:user) }
  let(:shareholder_relationship) { shareholder_follower.shareholder_relationships.build(shareholder_followed_id: shareholder_followed.id) }

  subject { shareholder_relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        ShareholderRelationship.new(shareholder_follower_id: shareholder_follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "follower methods" do
    it { should respond_to(:shareholder_follower) }
    it { should respond_to(:shareholder_followed) }
    its(:shareholder_follower) { should == shareholder_follower }
    its(:shareholder_followed) { should == shareholder_followed }
  end

  describe "when followed id is not present" do
    before { shareholder_relationship.shareholder_followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { shareholder_relationship.shareholder_follower_id = nil }
    it { should_not be_valid }
  end
end
