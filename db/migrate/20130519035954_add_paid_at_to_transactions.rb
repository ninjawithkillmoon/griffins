class AddPaidAtToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :paid_at, :date
  end
end
