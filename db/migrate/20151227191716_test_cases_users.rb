class TestCasesUsers < ActiveRecord::Migration
  def change
    create_table :test_cases_users, :id => false do |t|
      #Primitive Attributes
      t.integer :user_id
      t.integer :test_case_id
    end
  end
end
