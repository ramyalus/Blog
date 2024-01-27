class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  class << self
    def current_user=(user)      #setter method or writer method
      Thread.current[:current_user] = user
    end
 
    def current_user             #getter method or reader method
      Thread.current[:current_user]
    end
  end
end
