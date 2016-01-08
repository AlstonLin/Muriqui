class AddModeToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :mode, :string, default: "text/x-python"
  end
end
