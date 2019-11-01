class CreateTask < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :step_id

      t.timestamps
    end

    add_foreign_key :tasks, :steps, column: :step_id
  end
end
