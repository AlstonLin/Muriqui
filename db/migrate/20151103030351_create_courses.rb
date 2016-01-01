class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      #Primitive Attributes
      t.string :code
      t.string :name
      t.boolean :removed, default: false
      #Relationships
      t.belongs_to :creator
      t.belongs_to :remover
      #Auto-generated
      t.timestamps null: false
    end
  end
end
