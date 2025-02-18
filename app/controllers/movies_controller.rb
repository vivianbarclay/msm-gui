class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  
  def create
    new_movie = Movie.new
    new_movie.title = params[:title]
    new_movie.year = params[:year]
    new_movie.duration = params[:duration]
    new_movie.description = params[:description]
    new_movie.image = params[:image]
    new_movie.director_id = params[:director_id]
    new_movie.save

    redirect_to("/movies")
  end

  def update
    the_id = params.fetch("path_id")  # Define the_id properly
    find_movie = Movie.where({:id => the_id})
    update_movie = find_movie.at(0)

    update_movie.title = params[:title]
    update_movie.year = params[:year]
    update_movie.duration = params[:duration]
    update_movie.description = params[:description]
    update_movie.image = params[:image]
    update_movie.director_id = params[:director_id]
    update_movie.save

    redirect_to("/movies/#{the_id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    movie = Movie.find(the_id)
    movie.destroy
  
    redirect_to("/movies")
  end
  
end
