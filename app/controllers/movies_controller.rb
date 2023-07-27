class MoviesController < ApplicationController

  def index
    api_key = ENV['TMDB_API_KEY']
    response = HTTParty.get("https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}")
    @latest_movies = response["results"]
  end

  def show
    movie_id = params[:id]
    @movie = fetch_movie_details(movie_id)
  end

  private

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
