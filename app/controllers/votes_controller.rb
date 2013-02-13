class VotesController < ApplicationController
  before_filter :signed_in_user

  def create
    @vote = current_user.votes.where(:post_id => params[:vote][:post_id]).first
    @vote ||= current_user.votes.create(params[:vote])
    @vote.update_attributes(:up => params[:vote][:up])
    if @vote.save
      redirect_to :back
    else
      @comment_items = []
      #need to add render for errors
      redirect_to :back
    end
  end

end