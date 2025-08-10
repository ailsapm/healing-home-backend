class BlogPost < ApplicationRecord
  #associations
  belongs_to :user, foreign_key: :author_id
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :tags
  
  #validations
  validates :title, presence: true, uniqueness: true
  validates :body, :author_id, presence: true
end
