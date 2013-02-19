class CRelationshipsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  respond_to :html, :js

  def create
    @company = Company.find(params[:c_relationship][:c_followed_id])
    current_user.c_follow!(@company)
    respond_with @company
  end

  def destroy
    @company = CRelationship.find(params[:id]).c_followed
    current_user.c_unfollow!(@company)
    respond_with @company
  end
end