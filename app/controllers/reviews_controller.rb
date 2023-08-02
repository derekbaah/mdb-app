# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  def create
    #@movie = Movie.find(params[:movie_id])
    movie_id = params[:id]
    @movie = TmdbApi.fetch_movie_details(movie_id)
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to @movie, notice: 'Review successfully created!'
    else
      redirect_to @movie, alert: 'Error creating review.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :content, :rating)
  end
end
