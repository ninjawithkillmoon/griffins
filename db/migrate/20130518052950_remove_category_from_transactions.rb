class RemoveCategoryFromTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :category
  end

  def down
    add_column :transactions, :category, :string
  end
end
