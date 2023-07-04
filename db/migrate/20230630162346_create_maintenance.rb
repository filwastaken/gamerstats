class CreateMaintenance < ActiveRecord::Migration[6.1]
  def change
    create_table :maintenances do |t|
      t.timestamp :from, null: false
      t.timestamp :to
    end
  end
end
