class AddCityInStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :city, :string
  end
end
