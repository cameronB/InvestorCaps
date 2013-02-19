class CreateCRelationships < ActiveRecord::Migration
  def change
    create_table :c_relationships do |t|
      t.integer :c_follower_id
      t.integer :c_followed_id

      t.timestamps
    end

    add_index :c_relationships, :c_follower_id
    add_index :c_relationships, :c_followed_id
    add_index :c_relationships, [:c_follower_id, :c_followed_id], unique: true
  end
end
