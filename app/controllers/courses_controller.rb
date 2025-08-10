class CoursesController < ApplicationController

  #set course for show, update, and destroy actions, set_course defined below under private
  before_action :set_course, only: [:show, :update, :destroy]
  #only admin users can create, update, or delete courses, authorize_admin! from application_controller
  before_action :authorize_admin!, only: [:create, :update, :destroy]

   # GET /courses - list all courses, including associated author and category
  def index
    render json: Course.includes(:author, :category).all
  end

  # GET /courses/:id - show a specific course
  def show
    render json: @course
  end

  # POST /courses - create a new course (admin only)
  def create
    course = Course.new(course_params)
    course.author = current_user  #associate course with the user creating it
    if course.save
      #if successful, return the course w/ status 201
      render json: course, status: :created
    #if unsuccessful, return error w/ status 422
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/:id - update a course (admin only)
  def update
    if @course.update(course_params)
      #if successful, return updated course
      render json: @course
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:id - delete a course (admin only)
  def destroy
    @course.destroy
    render json: { message: "Course deleted" }
  end

  private

  #find the course by ID before show, update and destroy actions
  def set_course
    @course = Course.find(params[:id])
  end

  #strong parameters -  allowed fields for course creation/update
  def course_params
    params.require(:course).permit(:title, :description, :image_url, :category_id, :requires_purchase, :price)
  end

end
