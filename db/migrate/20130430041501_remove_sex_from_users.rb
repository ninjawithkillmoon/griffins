class RemoveSexFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :sex
  end

  def down
    add_column :users, :sex, :integer
  end
end
