class MoviesController < ApplicationController
  def index
    puts "Movies count: #{Movie.count}"
    @movies = Movie.all
  end
end
