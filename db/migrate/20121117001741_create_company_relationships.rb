class CreateCompanyRelationships < ActiveRecord::Migration
  def change
    create_table :company_relationships do |t|
      t.integer :company_follower_id
      t.integer :company_followed_id

      t.timestamps
    end

    add_index :company_relationships, :company_follower_id
    add_index :company_relationships, :company_followed_id
    add_index :company_relationships, [:company_follower_id, :company_followed_id], unique: true
  end
end
