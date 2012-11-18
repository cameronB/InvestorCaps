class CompanyRelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js

  def create
    @company = Company.find(params[:company_relationship][:cfollowed_id])
    current_user.cfollow!(@company)
    respond_with @company
  end

  def destroy
    @company = CompanyRelationship.find(params[:id]).cfollowed
    current_user.cunfollow!(@company)
    respond_with @company
  end
end