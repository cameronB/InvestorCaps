class AddUpToPostVotes < ActiveRecord::Migration
  def change
  	    add_column :post_votes, :up, :boolean
  end
end
