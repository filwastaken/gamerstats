class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :validatable, :lockable, :confirmable
end
