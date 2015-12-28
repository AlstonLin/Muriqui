class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
    	t.string :input
     	t.string :output
    	t.boolean :removed, default: false

    	t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :problem

      t.timestamps null: false
    end
  end
end
