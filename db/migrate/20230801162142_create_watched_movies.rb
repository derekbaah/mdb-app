class CreateWatchedMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :watched_movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.string :poster_path

      t.timestamps
    end
  end
end
