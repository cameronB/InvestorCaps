# == Schema Information
#
# Table name: company_relationships
#
#  id                  :integer          not null, primary key
#  company_follower_id :integer
#  company_followed_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe CompanyRelationship do

  let(:company_follower) { FactoryGirl.create(:user) }
  let(:company_followed) { FactoryGirl.create(:company) }
  let(:company_relationship) { company_follower.company_relationships.build(company_followed_id: company_followed.id) }

  subject { company_relationship }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to follower_id" do
      expect do
        CompanyRelationship.new(company_follower_id: company_follower.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when company followed id is not present" do
    before { company_relationship.company_followed_id = nil }
    it { should_not be_valid }
  end

  describe "when company follower id is not present" do
    before { company_relationship.company_follower_id = nil }
    it { should_not be_valid }
  end


  describe "company_follower methods" do
    it { should respond_to(:company_follower) }
    it { should respond_to(:company_followed) }
    its(:company_follower) { should == company_follower }
    its(:company_followed) { should == company_followed }
  end
end
