class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :number
      t.integer :part
      t.boolean :removed, default: false
      t.text :source
      t.text :generated_source

      t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :assignment

      t.timestamps null: false
    end
  end
end
