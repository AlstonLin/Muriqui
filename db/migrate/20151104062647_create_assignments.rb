class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.string :name
      t.boolean :removed, default: false
      t.date :due

      t.belongs_to :creator
      t.belongs_to :remover
      t.belongs_to :course

      t.timestamps null: false
    end
  end
end
