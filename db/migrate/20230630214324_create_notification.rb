class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :from, null: false
      t.integer :to, null: false

      t.boolean :fromUser
      t.boolean :toUser

      t.boolean :isuser, deafult: false
      t.string :body, null: false

      t.boolean :isinvitation, default: false
      t.integer :teamid

      t.timestamps
    end
  end
end
