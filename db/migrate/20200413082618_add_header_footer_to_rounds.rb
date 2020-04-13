class AddHeaderFooterToRounds < ActiveRecord::Migration[6.0]
  def change
    change_table :rounds, bulk: true do |t|
      t.string :header
      t.string :footer
    end
  end
end
