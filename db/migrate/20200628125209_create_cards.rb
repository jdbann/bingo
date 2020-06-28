class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.belongs_to :round, null: false, foreign_key: true
      t.string :code, null: false
      t.index :code, unique: true

      t.timestamps
    end
  end
end
