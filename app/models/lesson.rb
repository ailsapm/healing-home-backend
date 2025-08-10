class Lesson < ApplicationRecord
  #associations
  belongs_to :course
  has_many :lesson_completions, dependent: :destroy

  #validations
  validates :title, presence: true
end
