class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.boolean :completed, null: false, default: false
      t.boolean :archived, null: false, default: false
      t.integer :order, null: false, default: 0
      t.timestamps
    end
  end
end
