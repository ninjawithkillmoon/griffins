class AddOutstandingToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :outstanding, :integer
  end
end
