class AddSeasonIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :season_id, :integer
  end
end
