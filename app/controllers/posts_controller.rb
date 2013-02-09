class PostsController < ApplicationController
before_filter :signed_in_user, only: [:create, :destroy]
before_filter :correct_user, only: :destroy

def index

end

def create
   #check if the symbol that the user wishes to post about exists in the companies database table
   @symbol_count = Post.count_by_sql(["SELECT COUNT(*)
                                        FROM Companies
                                          WHERE symbol = ?", params[:post][:symbol]])

    #build the post using the parameters
    @post = current_user.posts.build(params[:post])
    #if the post paramters are valid and the company does exist then create post
    if @post.valid? == true && @symbol_count > 0
        @post.save
        flash[:success] = "Post created!"
        redirect_to root_url
    #if the post paramters are valid but the company does not exist then do not create a post
    elsif @post.valid? == true && @symbol_count < 1
        flash[:failed] = "Company does not exist!"
        redirect_to root_url
    #if the post paramters are not valid render errors for incorrect paramters
    elsif @post.valid? == false
        @feed_items = []
        #need to add render for errors
        redirect_to :back
    end
end

def destroy
     @post.destroy
     @post.comments.each{|comment|comment.destroy}
     flash[:success] = "Post Deleted."
     redirect_to root_url
end

private

    def correct_user
      @post = Post.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
    end

end