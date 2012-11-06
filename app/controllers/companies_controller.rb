class CompaniesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]

  def show
    @company = Company.find(params[:id])
  end

  def index
    @companies = Company.paginate(page: params[:page])
  end

  def new
  end

end
