class RemovePayments < ActiveRecord::Migration
  def up
    drop_table :payments
  end

  def down
    create_table :payments do |t|
      t.decimal :amount
      t.integer :method
      t.text :notes
      t.integer :invoice_id

      t.timestamps
    end
  end
end
