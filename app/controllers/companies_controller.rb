class CompaniesController < ApplicationController
  before_filter :signed_in_user, only: :index
  before_filter :admin_user,     only: :destroy

  def show
    @company = Company.find_by_symbol(params[:id])
    @posts = @company.posts.paginate(page: params[:page])
  end

  def index
    @companies = Company.paginate(page: params[:page])
  end

  def destroy
    @company = Company.find_by_symbol(params[:id])
    @company_symbol = @company.symbol
    Company.find_by_sql(["DELETE FROM Companies WHERE symbol = ?", @company_symbol])
    flash[:success] = "Company destroyed."
    redirect_to companies_path
  end

  def cfollowers
    @title = "Followers"
    @company = Company.find_by_symbol(params[:id])
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
