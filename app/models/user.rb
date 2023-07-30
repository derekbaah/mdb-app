class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associate movies with users with the watchlist model
  
  has_many :watchlist_movies, class_name: 'Watchlist', foreign_key: 'user_id', dependent: :destroy


end
