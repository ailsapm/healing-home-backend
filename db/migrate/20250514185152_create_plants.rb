class CreatePlants < ActiveRecord::Migration[8.0]
  def change
    create_table :plants do |t|
      t.string :common_name
      t.string :scientific_name
      t.string :family
      t.text :description
      t.text :growing_harvesting
      t.string :photo_url
      t.text :parts_used
      t.text :physiological_actions
      t.text :energetics
      t.text :ways_to_use
      t.text :uses
      t.text :cautions
      t.text :history
      t.text :magical
      t.boolean :is_sample, default: true, null: false

      t.timestamps
    end
  end
end
