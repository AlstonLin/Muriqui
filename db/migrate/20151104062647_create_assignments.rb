class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.string :name
    	t.belongs_to :course
    	t.references :problems
    	t.datetime :due
    end
  end
end
