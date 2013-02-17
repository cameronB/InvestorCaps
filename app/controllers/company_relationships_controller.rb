class CompanyRelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @company = Company.find(params[:company_relationship][:company_followed_id])
    current_user.company_follow!(@company)
    respond_with @company
  end

  def destroy
    @company = CompanyRelationship.find(params[:id]).company_followed
    current_user.company_unfollow!(@company)
    respond_with @company
  end
end