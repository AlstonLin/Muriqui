class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image
      t.string :token
      t.references :courses_created
      t.references :assignments_created
      t.references :test_cases_created
      t.datetime :expires_at
      t.timestamps null: false
    end
  end
end
