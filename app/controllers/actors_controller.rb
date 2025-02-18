class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  
  def create
    new_actor = Actor.new
    new_actor.name = params[:name]
    new_actor.dob = params[:dob]
    new_actor.bio = params[:bio]
    new_actor.image = params[:image]
    new_actor.save

    redirect_to("/actors")
  end

  def update
    the_id = params.fetch("path_id")  # Define the_id properly
    find_actor = Actor.where({:id => the_id})
    update_actor = find_actor.at(0)

    update_actor.name = params[:name]
    update_actor.dob = params[:dob]
    update_actor.bio = params[:bio]
    update_actor.image = params[:image]
    update_actor.save

    redirect_to("/actors/#{the_id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    actor = Actor.find(the_id)
    actor.destroy
  
    redirect_to("/actors")
  end

end
