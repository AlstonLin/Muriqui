class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.belongs_to :assignment
      t.string :name
      t.timestamps null: false 
      t.references :creator
    end
  end
end
