class Comment < ApplicationRecord
  #associations
  belongs_to :user
  #allow comments to belong to different types of objects (blogposts, recipes)
  belongs_to :commentable, polymorphic: true

  #validations
  validates :body, presence: true, length: { minimum: 3, maximum: 1000 }
end
