require 'spec_helper'

describe CRelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:company) { FactoryGirl.create(:company) }

  before { sign_in user }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, c_relationship: { c_followed_id: company.id }
      end.to change(CRelationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, c_relationship: { c_followed_id: company.id }
      response.should be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.c_follow!(company) }
    let(:c_relationship) { user.c_relationships.find_by_c_followed_id(company) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: c_relationship.id
      end.to change(CRelationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: c_relationship.id
      response.should be_success
    end
  end
end