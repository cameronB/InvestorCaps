class CreateComments < ActiveRecord::Migration
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :message

      t.timestamps
    end
end
