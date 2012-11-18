class CompaniesController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :admin_user,     only: :destroy

  def show
    @company = Company.find(params[:id])
  end

  def index
    @companies = Company.paginate(page: params[:page])
  end

  def destroy
    Company.find(params[:id]).destroy
    flash[:success] = "Company destroyed."
    redirect_to companies_path
  end

  def cfollowers
    @title = "Followers"
    @company = Company.find(params[:id])
    @companies = @company.cfollowers.paginate(page: params[:page])
    render 'show_follow_companies'
  end

  def new
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
