class WatchedMoviesController < ApplicationController
  # Display a list of watched movies for the current user.
  def index
    @watched_movies = current_user.watched_movies
  end

  # Show details of a specific watched movie and enable creating a review for it.
  def show
    @watched_movie = WatchedMovie.find(params[:id])
    @review = @watched_movie.reviews.build
  end

  # Show a form to add a new movie to the watched library.
  def new
    @movie = TmdbApi.get_movie_details(params[:tmdb_id])
  end

  # Create a new movie entry in the watched library.
  def create
    @movie = TmdbApi.get_movie_details(params[:tmdb_id])
    
    if WatchedMovie.find_by(tmdb_id: @movie['id'])
      flash[:notice] = 'Movie already in watched library.'
    else
      watched_movie = current_user.watched_movies.build(
        tmdb_id: @movie['id'],
        title: @movie['title'],
        poster_path: @movie['poster_path']
      )

      if watched_movie.save
        flash[:notice] = 'Movie added to watched library.'
      else
        flash[:alert] = 'Failed to add movie to watched library.'
      end
    end

    redirect_to watched_movies_path
  end

  # Create a new review for a watched movie.
  def create_review
    @watched_movie = WatchedMovie.find(params[:id])
    @review = @watched_movie.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Review added successfully.'
    else
      flash[:alert] = 'Failed to add review.'
    end

    redirect_to watched_movie_path(@watched_movie)
  end

  private

  # Whitelist parameters for review creation.
  def review_params
    params.require(:review).permit(:rating, :comment, :user_id)
  end
end
