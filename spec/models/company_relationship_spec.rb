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

require 'spec_helper'

describe CompanyRelationship do

  let(:cfollower) { FactoryGirl.create(:user) }
  let(:cfollowed) { FactoryGirl.create(:company) }
  let(:company_relationship) { cfollower.company_relationships.build(cfollowed_id: cfollowed.id) }

  subject { company_relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        CompanyRelationship.new(cfollower_id: cfollower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when company followed id is not present" do
    before { company_relationship.cfollowed_id = nil }
    it { should_not be_valid }
  end

  describe "when company follower id is not present" do
    before { company_relationship.cfollower_id = nil }
    it { should_not be_valid }
  end


  describe "company_follower methods" do
    it { should respond_to(:cfollower) }
    it { should respond_to(:cfollowed) }
    its(:cfollower) { should == cfollower }
    its(:cfollowed) { should == cfollowed }
  end
end
