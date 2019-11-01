class CreateStep < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.integer :board_id

      t.timestamps
    end

    add_foreign_key :steps, :boards, column: :board_id
  end
end
