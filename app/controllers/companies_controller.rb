class CompaniesController < ApplicationController
  before_filter :signed_in_user, only: [:show, :index, :c_followers]
  before_filter :admin_user,     only: :destroy

  def show
    @company = Company.find_by_symbol(params[:id])
    @company_symbol = @company.symbol
    @posts = @company.posts.paginate_by_sql(["SELECT posts.* 
                                              From posts 
                                              INNER JOIN companies ON posts.symbol=companies.symbol
                                              INNER JOIN users ON posts.user_id=users.id
                                              Where posts.symbol = ?", @company_symbol], :page => @page)
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

  def c_followers
    @title = "Followers"
    @company = Company.find_by_symbol(params[:id])
    @companies = @company.c_followers.paginate(page: params[:page])
    render 'show_follow_companies'
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
