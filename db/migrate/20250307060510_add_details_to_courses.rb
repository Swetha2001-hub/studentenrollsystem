class AddDetailsToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :duration, :string
    add_column :courses, :instructor, :string
    add_column :courses, :price, :decimal
  end
end
