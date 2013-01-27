class CommentsController < ApplicationController 
	before_filter :redirect_back_unless_logged_in

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	def new

	end

	def create
		@comment = current_user.comments.create(params[:comment])
		redirect_to :back
	end

	def redirect_back_unless_logged_in
    	redirect_to :back unless current_user.present?
  	end

end
