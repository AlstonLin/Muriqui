class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
    	t.belongs_to :problem
    	t.string :input
     	t.string :output
    	t.boolean :legal
      t.timestamps null: false
    end
  end
end
