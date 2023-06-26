#class User < ApplicationRecord
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  
  #attr_accessor :playerid

  #enum role: { user: 0, teamLeader: 1, amministratore: 2, abbonato: 3, teamLeaderAbbonato: 4 }
  #after_initialize :set_default_role, :if => :new_record?
  #def set_default_role
  #  self.role ||= :user
  #end
#end
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: { user: 0, teamLeader: 1, amministratore: 2, abbonato: 3, teamLeaderAbbonato: 4 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end
end
