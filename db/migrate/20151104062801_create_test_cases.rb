class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
    	t.references :problem
    	t.string :input
     	t.string :output
    	t.boolean :legal
    	t.references :creator
      t.timestamps null: false
    end
  end
end
