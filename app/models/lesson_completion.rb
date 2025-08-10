class LessonCompletion < ApplicationRecord
  #associations
  belongs_to :user
  belongs_to :lesson
end
