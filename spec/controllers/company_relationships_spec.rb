require 'spec_helper'

describe CompanyRelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:company) { FactoryGirl.create(:company) }

  before { sign_in user }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, company_relationship: { company_followed_id: company.id }
      end.to change(CompanyRelationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, company_relationship: { company_followed_id: company.id }
      response.should be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.company_follow!(company) }
    let(:company_relationship) { user.company_relationships.find_by_company_followed_id(company) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: company_relationship.id
      end.to change(CompanyRelationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: company_relationship.id
      response.should be_success
    end
  end
end