class MoviesController < ApplicationController

  # Display movies currently playing in theatres from the API or search results based on query.
  def index
    if params[:query]
      # perform a movie search if there's a query
      @search_results = search_movies(params[:query])
      @latest_movies = [] # Empty to avoid showing duplicates.
    else
      # Fetch the latest movies currently playing in theaters.
      @latest_movies = TmdbApi.get_now_playing
      @search_results = [] # Empty the search_results array since there is no query.
    end
  end

  # Show details for each movie.
  def show
    movie_id = params[:id]
    @movie = TmdbApi.fetch_movie_details(movie_id)
  end

  # Allow logged-in users to add movies to the watchlist through the watchlist model.
  def add_to_watchlist
    movie_id = params[:id]

    if current_user
      # Check if the movie is already in the watchlist
      if current_user.watchlist_movies.exists?(tmdb_id: movie_id)
        flash[:notice] = 'Movie is already in your watchlist.'
      else
        # Fetch movie info from API and add to the user's watchlist
        movie_details = TmdbApi.fetch_movie_details(movie_id)
        if movie_details
          current_user.watchlist_movies.create(tmdb_id: movie_id, title: movie_details['title'], poster_path: movie_details['poster_path'])
          flash[:notice] = 'Movie added to your watchlist.'
        else
          flash[:alert] = 'Failed to add movie to your watchlist. Please try again later.'
        end
      end
    else
      flash[:alert] = 'You need to be logged in to add movies to your watchlist.'
    end

    redirect_to movie_path(movie_id)
  end

  # Remove movie from the watchlist.
  def remove_from_watchlist
    movie_id = params[:id]
    if current_user
      watchlist_movie = current_user.watchlist_movies.find_by(tmdb_id: movie_id)
      if watchlist_movie
        watchlist_movie.destroy
        flash[:notice] = 'Movie removed from your watchlist.'
      end
    end

    redirect_to movie_path(movie_id)
  end

  # Display watchlisted movies & info for the current user.
  def watchlist
    @watchlist_movies = current_user.watchlist_movies
  end

  # Perform a movie search based on the user's query.
  def search
    if params[:query]
      @search_results = TmdbApi.search_movies(params[:query])
    else
      @search_results = [] # Set to an empty array if no search query is provided.
    end
  end

  # Add a movie to the user's watched library.
  def add_to_watched_movies
    movie = TmdbApi.fetch_movie_details(params[:id])

    if current_user.watched_movies.find_by(tmdb_id: movie['id'])
      flash[:notice] = 'Movie already in watched library.'
    else
      current_user.watched_movies.create(tmdb_id: movie['id'], title: movie['title'], poster_path: movie['poster_path'])
      flash[:notice] = 'Movie added to watched library.'
    end

    redirect_to movie_path(params[:id])
  end
end
