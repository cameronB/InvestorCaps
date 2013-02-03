class CommentsController < ApplicationController 
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
		@comment_items = @post.comments.paginate(page: params[:page])
	end

	def new

	end

	def create
		@comment = current_user.comments.create(params[:comment])
		redirect_to :back
	end

	def destroy
     	@comment.destroy
     	flash[:success] = "Comment Deleted."
     	redirect_to :back
	end

	private

    def correct_user
      @comment = Comment.find_by_id(params[:id])
      redirect_to root_url if @comment.nil?
    end

end
