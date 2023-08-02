class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associate movies with users using the watchlist model.
  # The user has many watchlist_movies, which refers to the Watchlist model using the foreign key 'user_id'
  has_many :watchlist_movies, class_name: 'Watchlist', foreign_key: 'user_id', dependent: :destroy

  # The user has many watched_movies, which refers to the WatchedMovie model.
  has_many :watched_movies

  # The user has many reviews associated with them.
  has_many :reviews
end
