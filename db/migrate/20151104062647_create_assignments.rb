class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      #Primitive Attributes
    	t.string :name
      t.boolean :removed, default: false
      t.date :due
      #Relationships
      t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :course
      #Auto-generated
      t.timestamps null: false
    end
  end
end
