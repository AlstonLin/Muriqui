class CreateSourceCodes < ActiveRecord::Migration
  def change
    create_table :source_codes do |t|
      t.string :name
      t.string :attachment
      t.references :owner, index: true
      t.references :problem, index: true
      t.timestamps null: false
    end
  end
end
