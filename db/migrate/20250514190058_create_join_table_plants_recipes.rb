class CreateJoinTablePlantsRecipes < ActiveRecord::Migration[8.0]
  def change
    create_join_table :plants, :recipes do |t|
      t.index [:plant_id, :recipe_id]
      t.index [:recipe_id, :plant_id]
    end
  end
end
