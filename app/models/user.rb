class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:bnet]
  
  enum role: { user: 0, teamLeader: 1, abbonato: 2, teamLeaderAbbonato: 3 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.from_omniauth(auth)
    where(uid:auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
