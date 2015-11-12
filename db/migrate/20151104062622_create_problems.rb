class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.belongs_to :assignment
      t.integer :number
      t.integer :part 
      t.string :file_name
      t.string :function_name
      t.timestamps null: false 
      t.references :creator
      t.text :source
    end
  end
end
