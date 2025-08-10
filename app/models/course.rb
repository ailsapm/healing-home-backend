class Course < ApplicationRecord
  #associations
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :category, class_name: 'CourseCategory'
  
  #if course is deleted so are associated lessons
  has_many :lessons, dependent: :destroy
  has_many :course_progresses
  has_many :purchases

  #validations
  #price required if  course requires purchase - if price is present it must be a number ≥ 0
  validates :title, :description, presence: true
  validates :price, presence: true, if: :requires_purchase?
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
