class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :notes
      t.decimal :amount

      t.timestamps
    end
  end
end
