class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :problem
      t.references :source, index: true
      t.references :owner, index: true
      t.timestamps null: false
    end
  end
end
