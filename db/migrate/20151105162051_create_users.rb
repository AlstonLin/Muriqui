class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      #Primitive Attributes
      t.boolean :admin, default: false
      #Facebook Auth variables
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image
      t.string :token
      t.datetime :expires_at
      #Auto-generated
      t.timestamps null: false
    end
  end
end
