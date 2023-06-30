class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :validatable, :lockable
end
