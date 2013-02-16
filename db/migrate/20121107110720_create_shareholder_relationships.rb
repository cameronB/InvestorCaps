class CreateShareholderRelationships < ActiveRecord::Migration
  def change
    create_table :shareholder_relationships do |t|
      t.integer :shareholder_follower_id
      t.integer :shareholder_followed_id

      t.timestamps
    end

    add_index :shareholder_relationships, :shareholder_follower_id
    add_index :shareholder_relationships, :shareholder_followed_id
    add_index :shareholder_relationships, [:shareholder_follower_id, :shareholder_followed_id], unique: true
  end
end