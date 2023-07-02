class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :from, null: false
      t.integer :to, null: false
      t.boolean :isuser, deafult: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
