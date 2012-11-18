class CreateCompanyRelationships < ActiveRecord::Migration
  def change
    create_table :company_relationships do |t|
      t.integer :cfollower_id
      t.integer :cfollowed_id

      t.timestamps
    end

    add_index :company_relationships, :cfollower_id
    add_index :company_relationships, :cfollowed_id
    add_index :company_relationships, [:cfollower_id, :cfollowed_id], unique: true
  end
end
