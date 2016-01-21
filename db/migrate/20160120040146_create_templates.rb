class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      # Basic Attributes
      t.boolean :removed, default: false
      t.text :code
      t.text :instructions
      t.string :mode
      t.string :name
      # Relationships
      t.belongs_to :creator
      t.belongs_to :remover
      t.timestamps null: false
    end
  end
end
