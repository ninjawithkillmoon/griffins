class AddStudentCeasedToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :student_ceased, :boolean
  end
end
