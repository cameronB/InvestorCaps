class SRelationshipsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  respond_to :html, :js

  def create
    @user = User.find(params[:s_relationship][:s_followed_id])
    current_user.s_follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = SRelationship.find(params[:id]).s_followed
    current_user.s_unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end