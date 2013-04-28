class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name_family
      t.string :name_given
      t.integer :student_number
      t.string :email
      t.boolean :male
      t.date :date_of_birth

      t.timestamps
    end
  end
end
