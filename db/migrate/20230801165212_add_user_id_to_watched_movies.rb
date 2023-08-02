class AddUserIdToWatchedMovies < ActiveRecord::Migration[6.1]
  def change
    add_reference :watched_movies, :user, null: false, foreign_key: true
  end
end
