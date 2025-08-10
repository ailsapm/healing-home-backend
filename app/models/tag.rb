class Tag < ApplicationRecord
    has_and_belongs_to_many :blog_posts
    has_and_belongs_to_many :recipes
    validates :name, presence: true, uniqueness: true
  end
  