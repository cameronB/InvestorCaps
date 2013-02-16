require 'spec_helper'

describe ShareholderRelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creating a relationship with Ajax" do

    it "should increment the shareholder Relationship count" do
      expect do
        xhr :post, :create, shareholder_relationship: { shareholder_followed_id: other_user.id }
      end.to change(ShareholderRelationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, shareholder_relationship: { shareholder_followed_id: other_user.id }
      response.should be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.shareholder_follow!(other_user) }
    let(:shareholder_relationship) { user.shareholder_relationships.find_by_shareholder_followed_id(other_user) }

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: shareholder_relationship.id
      end.to change(ShareholderRelationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: shareholder_relationship.id
      response.should be_success
    end
  end
end