class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :test_case
      t.references :source_code, index: true
      t.references :owner, index: true
      t.string :input
    	t.string :outactual
      t.string :outexpected
      t.boolean :passed
      t.timestamps null: false
    end
  end
end
