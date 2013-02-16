class CreateCommentVotes < ActiveRecord::Migration
    create_table :comment_votes do |t|
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
end
