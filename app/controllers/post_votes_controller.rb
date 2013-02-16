class PostVotesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :post_vote_exists, only: :destroy

  def create
    @post_vote = current_user.post_votes.where(:post_id => params[:post_vote][:post_id]).first
    @post_vote ||= current_user.post_votes.create(params[:post_vote])
    @post_vote.update_attributes(:up => params[:post_vote][:up])
    if @post_vote.save
      redirect_to :back
    else
      #need to add render for errors
      flash[:error] = 'Vote not registered, please try again!'
      redirect_to :back
    end
  end

  #destroy vote
  def destroy
      @post_vote.destroy
      redirect_to :back
  end

    private

    def post_vote_exists
      @post_vote = PostVote.find_by_id(params[:id])
      redirect_to :back if @post_vote.nil?
    end


end