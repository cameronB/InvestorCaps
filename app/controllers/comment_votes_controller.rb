class CommentVotesController < ApplicationController
  before_filter :signed_in_user

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

end