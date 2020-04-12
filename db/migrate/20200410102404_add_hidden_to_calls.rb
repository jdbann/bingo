class AddHiddenToCalls < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :hidden, :boolean, default: true
  end
end
