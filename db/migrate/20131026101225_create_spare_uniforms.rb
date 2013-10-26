class CreateSpareUniforms < ActiveRecord::Migration
  def change
    create_table :spare_uniforms do |t|
      t.integer :number
      t.string :size

      t.timestamps
    end
  end
end
