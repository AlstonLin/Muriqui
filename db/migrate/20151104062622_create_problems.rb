class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      #Primitive Attributes
      t.integer :number
      t.integer :part
      t.boolean :removed, default: false
      t.text :source
      t.text :instructions
      t.text :generated_source
      #Relationships
      t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :assignment
      #Auto-generated
      t.timestamps null: false
    end
  end
end
