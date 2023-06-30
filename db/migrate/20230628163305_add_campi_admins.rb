class AddCampiAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :full_name, :string
    add_column :admins, :bell, :boolean
  end
end
