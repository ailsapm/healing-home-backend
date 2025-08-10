class CreateJoinTableBlogPostsTags < ActiveRecord::Migration[8.0]
  def change
    create_join_table :blog_posts, :tags do |t|
      #adding indexes to improve query performance
      t.index [:blog_post_id, :tag_id]
      t.index [:tag_id, :blog_post_id]
    end
  end
end
