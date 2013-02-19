class CreateSRelationships < ActiveRecord::Migration
  def change
    create_table :s_relationships do |t|
      t.integer :s_follower_id
      t.integer :s_followed_id

      t.timestamps
    end

    add_index :s_relationships, :s_follower_id
    add_index :s_relationships, :s_followed_id
    add_index :s_relationships, [:s_follower_id, :s_followed_id], unique: true
  end
end