class AddInvoiceIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :invoice_id, :integer
  end
end
