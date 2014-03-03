class AddCompleteByToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :complete_by, :date
  end
end
