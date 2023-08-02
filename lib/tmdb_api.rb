require 'httparty'

module TmdbApi
  BASE_URL = 'https://api.themoviedb.org/3/'
  API_KEY = ENV['TMDB_API_KEY']

  # fetch movies currently playing in theatres
  def self.get_now_playing
    response = get_request('movie/now_playing')
    response.code == 200 ? parse_response(response)['results'] : []
  end

  # movie specific details 
  def self.fetch_movie_details(movie_id)
    response = get_request("movie/#{movie_id}")
    response.code == 200 ? parse_response(response) : nil
  end

  # search for movies based on user query
  def self.search_movies(query)
    response = get_request('search/movie', { query: query })
    response.code == 200 ? parse_response(response)['results'] : []
  end

  private

  # HTTP GET request to the TMDB API with the specified endpoint and parameters
  def self.get_request(endpoint, params = {})
    url = "#{BASE_URL}#{endpoint}"
    params[:api_key] = API_KEY
    params[:language] = 'en-US'
    response = HTTParty.get(url, query: params)
  end

  #Parse the JSON response from the HTTP request
  def self.parse_response(response)
    JSON.parse(response.body)
  end
end
