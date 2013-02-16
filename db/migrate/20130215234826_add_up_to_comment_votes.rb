class AddUpToCommentVotes < ActiveRecord::Migration
  def change
  	    add_column :comment_votes, :up, :boolean
  end
end
