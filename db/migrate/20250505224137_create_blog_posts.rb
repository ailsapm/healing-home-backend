class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.string :image_url

      t.timestamps
    end
    
    add_index :blog_posts, :title, unique: true
  end
end
