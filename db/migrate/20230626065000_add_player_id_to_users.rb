class AddPlayerIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :playerid, :string
  end
end
