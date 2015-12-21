class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.belongs_to :assignment
      t.integer :number
      t.integer :part
      t.text :source
      t.timestamps null: false
      t.references :creator
      t.text :source
      t.text :generated_source
    end
  end
end
