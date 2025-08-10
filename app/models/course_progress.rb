class CourseProgress < ApplicationRecord
  #associations
  belongs_to :user 
  belongs_to :course
  belongs_to :current_lesson, class_name: "Lesson", optional: true

  #to set a default starting lesson before the record is created
  before_create :set_default_lesson

  private

  #if no current_lesson is manually set, default to the first lesson in the course
  def set_default_lesson
    self.current_lesson ||= course.lessons.order(:lesson_order).first
  end
end
