class MoviesController < ApplicationController

  # display popular movies from api
  def index
    api_key = ENV['TMDB_API_KEY']
    response = HTTParty.get("https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}")
    @latest_movies = response["results"]
  end

  # show details for each movie
  def show
    movie_id = params[:id]
    @movie = fetch_movie_details(params[:id])
  end

  # allow logged in users to add movies to watchlist through the watchlist model
  def add_to_watchlist
    movie_id = params[:id]

    if current_user
      # Check if the movie is already in the watchlist
      if current_user.watchlist_movies.exists?(tmdb_id: movie_id)
        flash[:notice] = 'Movie is already in your watchlist.'
      else
        # Fetch movie info from API and add to user watchlist
        movie_details = fetch_movie_details(movie_id)
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

  # remove movie from watchlist :(
  def remove_from_watchlist
    movie_id = params[:id]
    if current_user
      watchlist_movie = current_user.watchlist_movies.find_by(tmdb_id: movie_id)
      if watchlist_movie
        watchlist_movie.destroy
        flash[:notice] = 'Movie removed from your watchlist.'
      else
        flash[:alert] = 'Movie is not in your watchlist.'
      end
    else
      flash[:alert] = 'You need to be logged in to remove movies from your watchlist.'
    end

    redirect_to movie_path(movie_id)
  end

  # display watchlisted movies & info
  def watchlist
    @watchlist_movies = current_user.watchlist_movies
  end


  private

  # fetch details for each movie
  def fetch_movie_details(movie_id)
    base_url = 'https://api.themoviedb.org/3/movie/'
    api_key = ENV['TMDB_API_KEY']
    url = "#{base_url}#{movie_id}?api_key=#{api_key}&language=en-US"

    response = HTTParty.get(url)

    if response.code == 200
      return JSON.parse(response.body)
    else
      # Handle error, e.g., movie not found
      return nil
    end
  end



end
