class LessonsController < ApplicationController
  #find lesson by ID for the mentioned actions, set_lesson defined below under private
  before_action :set_lesson, only: [:show, :update, :destroy]
  #only allow admin to do the mentioned actions - authorize_admin! defined in application_controller
  before_action :authorize_admin!, only: [:create, :update, :destroy]

  # GET /lessons?course_id= - list lessons for a specific course
  def index
    if params[:course_id]
      lessons = Lesson.where(course_id: params[:course_id]).order(:lesson_order) #fetch & order lessons by course
      render json: lessons
    else
      render json: { error: "course_id param required" }, status: :bad_request  #error if course_id missing
    end
  end

  # GET /lessons/:id - show a single lesson
  def show
    render json: @lesson
  end

  # POST /lessons - create a new lesson - admin only
  def create
    lesson = Lesson.new(lesson_params)
    if lesson.save
      render json: lesson, status: :created  #return created lesson w/ 201 status
    else
      render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity  #error
    end
  end

  # PATCH/PUT /lessons/:id - update a lesson - admin only
  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/:id - delete a lesson (admin only)
  def destroy
    @lesson.destroy
    render json: { message: "Lesson deleted" }
  end

  private

  #set lesson for actions that need an existing lesson
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  #strong params - allow only these lesson attributes
  def lesson_params
    params.require(:lesson).permit(:course_id, :title, :video_url, :content_body, :lesson_order)
  end
end
