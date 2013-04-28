class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :date_start
      t.decimal :cost
      t.decimal :cost_student

      t.timestamps
    end
  end
end
