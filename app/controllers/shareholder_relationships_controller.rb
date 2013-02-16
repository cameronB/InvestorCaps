class ShareholderRelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @user = User.find(params[:shareholder_relationship][:shareholder_followed_id])
    current_user.shareholder_follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = ShareholderRelationship.find(params[:id]).shareholder_followed
    current_user.shareholder_unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end