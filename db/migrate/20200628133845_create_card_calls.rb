class CreateCardCalls < ActiveRecord::Migration[6.0]
  def change
    create_table :card_calls do |t|
      t.belongs_to :card, null: false, foreign_key: true
      t.belongs_to :call, null: false, foreign_key: true
      t.boolean :marked, default: false

      t.timestamps
    end
  end
end
