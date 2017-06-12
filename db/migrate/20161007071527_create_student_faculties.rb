class CreateStudentFaculties < ActiveRecord::Migration[5.0]
  def change
    create_table :student_faculties do |t|
      t.integer :student_id
      t.integer :faculty_id
      t.boolean :disable,            default: false

      t.timestamps
    end
  end
end
