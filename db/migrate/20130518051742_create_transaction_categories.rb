class CreateTransactionCategories < ActiveRecord::Migration
  def change
    create_table :transaction_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
