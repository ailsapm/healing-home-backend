class RecipesController < ApplicationController
  #only allow admin users to create, update, or delete recipes - authorize_admin! comes from the application_controller
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  
    #GET /recipes - Return all recipes including associated user (just username) and tags (just name)
    def index
      recipes = Recipe.includes(:user, :tags).all
      render json: recipes.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
    end
  
    #GET /recipes/:id - return a single recipe by ID, with user and tags info
    def show
      recipe = Recipe.includes(:user, :tags).find_by(id: params[:id])
      if recipe
        render json: recipe.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
      else
        render json: { error: "Recipe not found" }, status: :not_found
      end
    end
  
    #GET /recipes/search?ingredient=... - search recipes where ingredient matches the query - defined in recipe.rb
    def search
      ingredient = params[:ingredient]
      recipes = Recipe.includes(:user, :tags).search_by_ingredient(ingredient)
  
      if recipes.present?
        render json: recipes.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } }), status: :ok
      else
        render json: { error: "No recipes found for #{ingredient}" }, status: :not_found
      end
    end

    #GET /recipes/by_tag?tag=  - find recipes associated with a specific tag like herbal tea
    def by_tag
        tag = Tag.find_by(name: params[:tag])
        if tag
          recipes = tag.recipes.includes(:user, :tags)
          render json: recipes.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
        else
          render json: { error: "Tag not found" }, status: :not_found
        end
      end
      

    #POST /recipes - createnew  recipe and associates it with tags and plants by name
    def create
      #doing this in stages, first create recipe without tags/plants
      recipe = Recipe.new(recipe_params.except(:tag_names, :plant_names))
      recipe.user = current_user
  
      #handle tag creation/association
      if params[:recipe][:tag_names]
        tag_names = params[:recipe][:tag_names]
        tags = Tag.where(name: tag_names).to_a
  
        #create any tags that don't already exist
        missing_names = tag_names - tags.map(&:name)
        missing_tags = missing_names.map { |name| Tag.create(name: name) }
        recipe.tags = tags + missing_tags
      end

        #handle association by plant common names
        if params[:recipe][:plant_names]
        plant_names = params[:recipe][:plant_names]
        plants = Plant.where(common_name: plant_names)
        recipe.plants = plants
      end
  
      if recipe.save
        render json: recipe.as_json(include: { user: { only: [:username] }, tags: { only: [:name] }, plants: { only: [:common_name] } }), status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
#PATCH/PUT /recipes/:id - update recipe and associated tags and plants
def update
  recipe = Recipe.find_by(id: params[:id])
  return render json: { error: "Recipe not found" }, status: :not_found unless recipe

  if recipe.update(recipe_params.except(:tag_names, :plant_names))
    #update tags
    #if tags are entered in the frontend form
    if params[:recipe][:tag_names]
      #store array of entereed tags
      tag_names = params[:recipe][:tag_names]
      #get the tags in db that match the entered tags
      tags = Tag.where(name: tag_names).to_a
      #subtract the found tags from the entered tags to find which tags are missing
      missing_names = tag_names - tags.map(&:name)
      #create new tags for the missing ones
      missing_tags = missing_names.map { |name| Tag.create(name: name) }
      #add the missing tags to the existing tags to update the db records
      recipe.tags = tags + missing_tags
    end

    #update associated plants
    if params[:recipe][:plant_names]
      #store array of submitted plant names
      plant_names = params[:recipe][:plant_names]
      #find plant records where the common_name matches any of the submitted names
      plants = Plant.where(common_name: plant_names)
      #associate the found plants with the recipe
      recipe.plants = plants
    end

    render json: recipe.as_json(include: { user: { only: [:username] }, tags: { only: [:name] }, plants: { only: [:common_name] } })
  else
    render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
  end
end

  
    #DELETE /recipes/:id - deletesa recipe if it exists
    def destroy
      recipe = Recipe.find_by(id: params[:id])
      if recipe
        recipe.destroy
        render json: { message: "Recipe deleted successfully" }, status: :ok
      else
        render json: { error: "Recipe not found" }, status: :not_found
      end
    end
  
    private
  
    #strong parameters for creating/updating recipes
    #tag_names and plant_names are arrays from the frontend, entered by user via form or search input
    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :instructions, :image_url, :is_remedy, tag_names: [], plant_names: [])
    end
  end
  