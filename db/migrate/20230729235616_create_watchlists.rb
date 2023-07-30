class CreateWatchlists < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlists do |t|
      t.integer :tmdb_id
      t.string :title
      t.string :poster_path
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
