class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :credit
      t.string :method
      t.decimal :amount
      t.text :notes
      t.string :category

      t.timestamps
    end
  end
end
