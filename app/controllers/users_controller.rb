class UsersController < ApplicationController
  before_filter :signed_in_user,
                only: [:index, :edit, :update, :destroy, :shareholder_following, :shareholder_followers, :cfollowing]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by_username(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def cfollowing
    @title = "Following"
    @user = User.find_by_username(params[:id])
    @users = @user.cfollowed_companies.paginate(page: params[:page])
    render 'show_follow_companies'
  end

  def shareholder_following
    @title = "Following"
    @user = User.find_by_username(params[:id])
    @users = @user.shareholder_followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def shareholder_followers
    @title = "Followers"
    @user = User.find_by_username(params[:id])
    @users = @user.shareholder_followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to InvestorCaps!"
      redirect_to @user
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to :back
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by_username(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user =  User.find_by_username(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end