class CommentVotesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :comment_vote_exists, only: :destroy

  def create
    @comment_vote = current_user.comment_votes.where(:comment_id => params[:comment_vote][:comment_id]).first
    @comment_vote ||= current_user.comment_votes.create(params[:comment_vote])
    @comment_vote.update_attributes(:up => params[:comment_vote][:up])
    if @comment_vote.save
      redirect_to :back
    else
      #need to add render for errors
      flash[:error] = 'Vote not registered, please try again!'
      redirect_to :back
    end
  end

  #destroy vote
  def destroy
      @comment_vote.destroy
      redirect_to :back
  end

  private

    #check that the comment exists in the database before attempting delete
    def comment_vote_exists
      @comment_vote = CommentVote.find_by_id(params[:id])
      redirect_to root_url if @comment_vote.nil?
    end

end