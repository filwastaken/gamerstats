class CreatePreferitos < ActiveRecord::Migration[6.1]
  def change
    create_table :preferitos do |t|
      t.string :mitt_id
      t.string :nome_dest
      t.string :dest_id

      t.timestamps
    end
  end
end
