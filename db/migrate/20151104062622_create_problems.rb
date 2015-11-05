class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.references :test_cases
      t.belongs_to :assignment
      t.string :name
      t.timestamps null: false 
    end
  end
end
