class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :comment
      t.integer :rating
      t.integer :watched_movie_id

      t.timestamps
    end
  end
end
