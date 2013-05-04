class ChangeAmountsToIntegers < ActiveRecord::Migration
  def up
    change_column :seasons,  :cost,         :integer
    change_column :seasons,  :cost_student, :integer
    change_column :invoices, :amount,       :integer
    change_column :payments, :amount,       :integer
  end

  def down
    change_column :seasons,  :cost,         :decimal
    change_column :seasons,  :cost_student, :decimal
    change_column :invoices, :amount,       :decimal
    change_column :payments, :amount,       :decimal
  end
end
