class RemoveUidFromTeamStats < ActiveRecord::Migration[6.1]
  def change
    remove_column :team_stats, :uid, :string
  end
end
