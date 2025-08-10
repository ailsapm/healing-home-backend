class Recipe < ApplicationRecord
    #associations
    belongs_to :user, foreign_key: :author_id
    has_many :comments, as: :commentable, dependent: :destroy
    has_and_belongs_to_many :plants
    has_and_belongs_to_many :tags
  
    #validations
    validates :title, presence: true, uniqueness: true
    validates :description, :ingredients, :instructions, :author_id, presence: true

    #class method to search all recipes by ingredient
    def self.search_by_ingredient(ingredient)
        #using case-insensitive ilike query to match recipes that contain the ingredient
        where("ingredients ILIKE ?", "%#{ingredient}%")
      end
  end
  
