class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.text :instructions
      t.string :image_url
      t.integer :author_id
      t.boolean :is_remedy

      t.timestamps
    end
  end
end
