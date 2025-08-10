class LessonCompletionsController < ApplicationController

  # POST /lesson_completions - create a new lesson completion record
  def create
    completion = LessonCompletion.new(lesson_completion_params)
    completion.user = current_user  #associate completion with current logged-in user
    completion.completed_at ||= Time.current  #set completion time to current time if not already there

    #if save successful, return the completion w/ HTTP status 201 created
    if completion.save
      render json: completion, status: :created
    #if it fails, return error w/ HTTP status 422 unprocessable entity
    else
      render json: { errors: completion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  #strong parameters -  only allow lesson_id and completed_at fields
  def lesson_completion_params
    params.require(:lesson_completion).permit(:lesson_id, :completed_at)
  end
end
