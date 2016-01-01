class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      #Primitive Attributes
    	t.string :input
     	t.string :output
    	t.boolean :removed, default: false
      #Relationships
    	t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :problem
      #Auto-generated
      t.timestamps null: false
    end
  end
end
