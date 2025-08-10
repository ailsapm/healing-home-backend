class CreateJoinTableRecipesTags < ActiveRecord::Migration[8.0]
  def change
    create_join_table :recipes, :tags do |t|
      #adding indexes for better querying
      t.index [:recipe_id, :tag_id]
      t.index [:tag_id, :recipe_id]
    end
  end
end
