class Team < ApplicationRecord
    has_one :team_stat, dependent: :destroy

    before_destroy :destroy_team_stat
    
    private
    
    def destroy_team_stat
        team_stat.destroy if team_stat.present?
    end
end
