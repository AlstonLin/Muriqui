class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.boolean :removed, default: false

      t.belongs_to :creator
      t.belongs_to :remover

      t.timestamps null: false
    end
  end
end
