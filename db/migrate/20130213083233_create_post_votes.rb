class CreateVotes < ActiveRecord::Migration
    create_table :post_votes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
end
