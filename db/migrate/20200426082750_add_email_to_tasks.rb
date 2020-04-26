class AddEmailToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :email, :string
    add_column :tasks, :string, :string
  end
end
