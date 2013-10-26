class AddSexToSpareUniforms < ActiveRecord::Migration
  def change
    add_column :spare_uniforms, :sex, :integer
  end
end
