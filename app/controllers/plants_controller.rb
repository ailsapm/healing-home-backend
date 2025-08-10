class PlantsController < ApplicationController
  #only admins can create, update or delete plant records, authorize_admin! defined in application_controller
  before_action :authorize_admin!, only: [:create, :update, :destroy]

  #GET /plants - fetch all plants, including associated recipes (only id and title)
  def index
    plants = Plant.includes(:recipes).all
    render json: plants.as_json(include: { recipes: { only: [:id, :title] } })
  end
  
  #GET /plants/:id - show specific plant by ID, including remedy recipes
  def show
    plant = Plant.includes(:recipes).find_by(id: params[:id])
    if plant
      render json: plant.as_json(include: { recipes: { only: [:id, :title] } })
    else
      render json: { error: "Plant not found" }, status: :not_found
    end
  end
  
  #GET /plants/search?query=... - #search plants by common or scientific name - case-insensitive
  def search
    query = params[:query]
    plants = Plant.where("common_name ILIKE ? OR scientific_name ILIKE ?", "%#{query}%", "%#{query}%")
      
    if plants.any?
      render json: plants, status: :ok
    else
      render json: { error: "No matching plants found" }, status: :not_found
    end
  end
  
  #POST /plants - create new plant record, then associate matching remedy recipes
  def create
    plant = Plant.new(plant_params)
  
    if plant.save
      associate_remedy_recipes(plant)
      render json: plant, status: :created
    else
      render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  #PATCH/PUT /plants/:id - update existing plant and re-associate remedy recipes
  def update
    plant = Plant.find_by(id: params[:id])
  
    if plant&.update(plant_params)
      associate_remedy_recipes(plant)
      render json: plant
    else
      render json: { error: "Plant not found or could not be updated" }, status: :unprocessable_entity
    end
  end
  
  #DELETE /plants/:id - delete plant by ID if it exists
  def destroy
    plant = Plant.find_by(id: params[:id])
  
    if plant
      plant.destroy
      render json: { message: "Plant deleted successfully" }
    else
      render json: { error: "Plant not found" }, status: :not_found
    end
  end
  
  private
  
  #strong parameters - only allow permitted fields for plants
  def plant_params
    params.require(:plant).permit(
      :common_name,
      :scientific_name,
      :family,
      :description,
      :growing_harvesting,
      :photo_url,
      :parts_used,
      :physiological_actions,
      :energetics,
      :ways_to_use,
      :uses,
      :cautions,
      :history,
      :magical,
      :is_sample
    )
  end
  
  #associate recipes marked as remedies where ingredients include the plant's common name
  #find all recipes where is_remedy = true, ingredients text has case insensitive (using ILIKE) match to common name
  def associate_remedy_recipes(plant)
    remedies = Recipe.where("is_remedy = ? AND ingredients ILIKE ?", true, "%#{plant.common_name}%")
    plant.recipes = remedies
  end
end
  