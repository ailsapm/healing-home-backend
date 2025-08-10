class CommentsController < ApplicationController
  # GET /comments?commentable_type=BlogPost&commentable_id=
  #get all comments for a specific "commentable" resource (either a blogpost or a)
  def index
    #get the type and ID of the thing being commented on (for example BlogPost with ID 1)
    commentable_type = params[:commentable_type]
    commentable_id = params[:commentable_id]
    #find all comments for that specific item, and load the related user to avoid extra queries
    comments = Comment.where(commentable_type: commentable_type, commentable_id: commentable_id)
                      .includes(:user)

    #return the comments in JSON format, including only the comment body and author's username
    render json: comments.as_json(
      only: [:id, :body, :user_id], 
      include: { user: { only: [:username] } }
    )
  end

  # POST /comments - create a new comment
  def create
    #create new comment with provided params (strong params defined below)
    comment = Comment.new(comment_params)
    #associate the comment with the currently logged-in user
    comment.user = current_user

    if comment.save
      #return the created comment with user info
      render json: comment.as_json(
        only: [:id, :body, :user_id], 
        include: { user: { only: [:username] } }
      ), status: :created
      
    else
      #f saving fails (for example validation errors), return error
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id - update an existing comment
  def update
    #find comment by id
    comment = Comment.find_by(id: params[:id])

    if comment.nil?
      #if not found, return a 404 error
      render json: { error: "Comment not found" }, status: :not_found
    elsif comment.user_id != current_user.id && !current_user.admin?
      #only the comment author or an admin can update the comment
      render json: { error: "Unauthorized to update this comment" }, status: :forbidden
    elsif comment.update(comment_params)
      #if update succeeds, return the updated comment
      render json: comment.as_json(
        only: [:id, :body, :user_id], 
        include: { user: { only: [:username] } }
      )
    else
      #if update fails, return the validation errors
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id  - delete a comment
  def destroy
    #find the commend by id
    comment = Comment.find_by(id: params[:id])

    if comment.nil?
      #if not found, return a 404 error
      render json: { error: "Comment not found" }, status: :not_found
    elsif comment.user_id != current_user.id && !current_user.admin?
      # Only the comment author or admin can delete it
      render json: { error: "Unauthorized to delete this comment" }, status: :forbidden
    else
      #delete comment
      comment.destroy
      render json: { message: "Comment deleted successfully" }, status: :ok
    end
  end

  private
  #strong parameters: only allow permitted fields to be submitted
  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
