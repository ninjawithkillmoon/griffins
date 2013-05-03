class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.integer :method
      t.text :notes

      t.timestamps
    end
  end
end
