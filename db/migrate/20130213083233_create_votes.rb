class CreateVotes < ActiveRecord::Migration
    create_table :votes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
end
