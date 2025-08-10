class CourseCategoriesController < ApplicationController
  #only allow admins to create or delete course categories, authorize_admin! from application_controller
  before_action :authorize_admin!, only: [:create, :destroy]

  # GET /course_categories - show a list of all categories
  def index
    render json: CourseCategory.all
  end

  # POST /course_categories - admin only, create new category
  def create 
    category = CourseCategory.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /course_categories/:id - admin only, delete the relevant category
  def destroy
    category = CourseCategory.find(params[:id])
    category.destroy
    render json: { message: "Category deleted" }
  end

  private

  #strong params for course category
  def category_params
    params.require(:course_category).permit(:name)
  end

end
