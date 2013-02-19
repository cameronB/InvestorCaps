require 'spec_helper'

describe SRelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creating a relationship with Ajax" do

    it "should increment the shareholder Relationship count" do
      expect do
        xhr :post, :create, s_relationship: { s_followed_id: other_user.id }
      end.to change(SRelationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, s_relationship: { s_followed_id: other_user.id }
      response.should be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.s_follow!(other_user) }
    let(:s_relationship) { user.s_relationships.find_by_s_followed_id(other_user) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: s_relationship.id
      end.to change(SRelationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: s_relationship.id
      response.should be_success
    end
  end
end