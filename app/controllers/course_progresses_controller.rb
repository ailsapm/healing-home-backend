class CourseProgressesController < ApplicationController
  ##before running show or update, find the specific CourseProgress record, set_progress defined below under private
  before_action :set_progress, only: [:show, :update]

  # POST /course_progresses - create new progress record for course for current user
  def create
    progress = CourseProgress.new(course_progress_params)
    progress.user = current_user
    #if no current lesson available, default to first lesson in course
    progress.current_lesson ||= progress.course.lessons.order(:lesson_order).first

    #if successful, return created progress w/ 201 status
    if progress.save
      render json: progress, status: :created
    else
      #if unsuccessful, return validation errors w/ 422 status
      render json: { errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /course_progresses/:id - update existing course progress record
  def update
    if @progress.update(course_progress_params)
      render json: @progress
    else
      render json: { errors: @progress.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /course_progresses/:id - show specific course progress record
  def show
    render json: @progress
  end

  private

  #find course progress record by ID
  def set_progress
    @progress = CourseProgress.find(params[:id])
  end

  #strong params to define allowed attributes
  def course_progress_params
    params.require(:course_progress).permit(:course_id, :current_lesson_id, :last_accessed_at, :completed)
  end
end
