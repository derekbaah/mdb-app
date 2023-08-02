This is a Rails 6 application that utilizes the TMDB (The Movie Database) API to fetch movie data and display it on the website. Users can search for movies, mark movies as watched, add movies to their watchlist, view movie details and and explore movies currently playing in the theatres.


# FEATURES

* View currently playing movies on the homepage
* Search for movies by title
* View movie details such as overview, release date, and average rating
* Indicated movies as watched
* Leave reviews and ratings on watched movies
* Add movies to watchlist
  
# TECHNOLOGIES

* Ruby on Rails 6: Web application framework
* TMDB API: Movie data source (you will need an API key)
* Bootstrap: CSS framework for responsive design
* SQLite3: Database to store movie information

# INSTALLATION

1. Clone the repository

git clone (https://github.com/derekbaah/mdb-app)
cd your-tmdb-app

2. Install dependencies

bundle install

3. Set up the database

rails db:create
rails db:migrate

4. Get your TMDB API key

Sign up for a free account on the TMDB website (https://www.themoviedb.org/?language=en-US)
Once you have an account, request an API key from the API settings page

5. Set your TMDB API key

6. Start the Rails server
rails server

# USAGE

* To search for movies, enter the movie title in the search bar and press Enter or click the search icon.
* Click on a movie card to view more details about the movie.
* To create an account, click on the "Sign in" button in the top navigation bar. Enter your email and password in the form to login. If you need to register a new account, click on the "Register" link.
* You need an account to add a movie to your watchlist, mark a movie as watched and also to review a watched movie.
* Click on the "Add to Watchlist" button on a movie page to add it to your watchlist
* Watchlist indicates movies a user intends to watch 
* Click on the "Add to Watched Movies" button to add a movie to your watched library.
* Watched movies indicate movies a user has already watched
