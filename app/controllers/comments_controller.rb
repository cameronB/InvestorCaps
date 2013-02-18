class CommentsController < ApplicationController 
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :comment_exists, only: :destroy

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
		#@comment_items = @post.comments.paginate(page: params[:page])

		@comment_items = @post.comments.paginate_by_sql("SELECT
  															c.*,
  															(SELECT
  															count(1)
   															FROM comment_votes v_t
   															WHERE v_t.up = 't' AND v_t.comment_id = c.id) AS upvotes,
  															(SELECT
  															count(1)
   															FROM comment_votes v_f
  														    WHERE v_f.up = 'f' AND v_f.comment_id = c.id) AS downvotes
															FROM comments c
															ORDER BY upvotes desc, downvotes asc", :page => @page)

	end

	def new

	end

  #create a comment on a posts
	def create
		@comment = current_user.comments.create(params[:comment])
		if @comment.save
			flash[:success] = "Comment added"
			redirect_to :back
		else
      		flash[:error] = 'Invalid Comment'
      		redirect_to :back
		end
	end

  #destroy comment
	def destroy
     	@comment.destroy
     	redirect_to :back
	end

	private

    #check comment exists before attempting to delete
    def comment_exists
      @comment = Comment.find_by_id(params[:id])
      redirect_to root_url if @comment.nil?
    end

end
