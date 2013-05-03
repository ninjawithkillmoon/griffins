class AddPlayerIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :player_id, :integer
  end
end
