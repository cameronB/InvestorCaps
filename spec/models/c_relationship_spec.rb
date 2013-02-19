# == Schema Information
#
# Table name: crelationships
#
#  id                  :integer          not null, primary key
#  c_follower_id :integer
#  c_followed_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe CRelationship do

  let(:c_follower) { FactoryGirl.create(:user) }
  let(:c_followed) { FactoryGirl.create(:company) }
  let(:c_relationship) { c_follower.c_relationships.build(c_followed_id: c_followed.id) }

  subject { c_relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        CRelationship.new(c_follower_id: c_follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when company followed id is not present" do
    before { c_relationship.c_followed_id = nil }
    it { should_not be_valid }
  end

  describe "when company follower id is not present" do
    before { c_relationship.c_follower_id = nil }
    it { should_not be_valid }
  end


  describe "company_follower methods" do
    it { should respond_to(:c_follower) }
    it { should respond_to(:c_followed) }
    its(:c_follower) { should == c_follower }
    its(:c_followed) { should == c_followed }
  end
end
