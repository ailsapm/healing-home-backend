class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :image_url
      t.references :category, null: false, foreign_key: { to_table: :course_categories }
      t.boolean :requires_purchase, default: true, null: false
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
