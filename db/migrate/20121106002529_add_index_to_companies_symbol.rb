class AddIndexToCompaniesSymbol < ActiveRecord::Migration
  def change
    add_index :companies, :symbol, unique: true
  end
end
