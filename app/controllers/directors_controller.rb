class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def createdirector
    new_director = Director.new
    new_director.name = params[:name]
    new_director.dob = params[:dob]
    new_director.bio = params[:bio]
    new_director.image = params[:image]
    new_director.save

    redirect_to("/directors")
  end

  def update
    the_id = params.fetch("path_id")  # Define the_id properly
    find_director = Director.where({:id => the_id})
    update_director = find_director.at(0)

    update_director.name = params[:name]
    update_director.dob = params[:dob]
    update_director.bio = params[:bio]
    update_director.image = params[:image]
    update_director.save

    redirect_to("/directors/#{the_id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    director = Director.find(the_id)
    director.destroy
  
    redirect_to("/directors")
  end
  
end
