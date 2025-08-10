class BlogPostsController < ApplicationController
#restrict access to create, update, and destroy actions to admins only, authorize_admin! from application_controller
before_action :authorize_admin!, only: [:create, :update, :destroy]

# GET /blog_posts - get all blog posts, including username and tags
def index
  blog_posts = BlogPost.all.includes(:user) # eager load user data
  render json: blog_posts.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
end
  
# GET /blog_posts/:id - get a particular blog post by id, including username, tags, comments and comment authors
def show
  blog_post = BlogPost.find_by(id: params[:id])
  if blog_post
    render json: blog_post.as_json(
      include: {
        user: { only: [:username] },
        tags: { only: [:name] },
        comments: {
          include: { user: { only: [:username] } },
          only: [:id, :body, :user_id]
        }
      }
    )
  else
    render json: { error: "Blog post not found" }, status: :not_found
  end
end

# GET /blog_posts/by_tag?tag=specifictagname - get all blog posts associated with a specific tag
def by_tag
    tag = Tag.find_by(name: params[:tag])
    if tag
      posts = tag.blog_posts.includes(:user, :tags)
      render json: posts.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
    else
      render json: { error: "Tag not found" }, status: :not_found
  end
end
      
  
# POST /blog_posts - create a new blog post, tag names optional
def create
  #create blog post from permitted params (excluding tags for now)
  blog_post = BlogPost.new(blog_post_params.except(:tag_names))
  blog_post.user = current_user
  
  #this part only runs if tag names are entered
  if params[:blog_post][:tag_names]
    tag_names = params[:blog_post][:tag_names]
    #find tags where name is in tag_names, then turn result into an array of tag objects
    tags = Tag.where(name: tag_names).to_a

    #create any tags that don't already exist
    #subtract all the existing tag names from the submitted tag names
    missing_names = tag_names - tags.map(&:name)
    #create a new tag record in db for each missing tag name
    missing_tags = missing_names.map { |name| Tag.create(name: name) }
    #assign all tags to the blog post
    blog_post.tags = tags + missing_tags
  end
  
  if blog_post.save
    render json: blog_post.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } }), status: :created
  else
    render json: { errors: blog_post.errors.full_messages }, status: :unprocessable_entity
  end
end
  
# PATCH/PUT /blog_posts/:id
def update
  blog_post = BlogPost.find_by(id: params[:id])
  return render json: { error: "Blog post not found" }, status: :not_found unless blog_post
  
  if blog_post.update(blog_post_params.except(:tag_names))
    #same as in def create above, this only runs if tag names are entered
    if params[:blog_post][:tag_names]
      #same as def create, check if tag exists, if not, create new tag
      tag_names = params[:blog_post][:tag_names]
      tags = Tag.where(name: tag_names).to_a
      missing_names = tag_names - tags.map(&:name)
      missing_tags = missing_names.map { |name| Tag.create(name: name) }
      blog_post.tags = tags + missing_tags
    end
  
    render json: blog_post.as_json(include: { user: { only: [:username] }, tags: { only: [:name] } })
  else
    render json: { errors: blog_post.errors.full_messages }, status: :unprocessable_entity
  end
end
  
# DELETE /blog_posts/:id - delete a specific blog post, if it exists
def destroy
  blog_post = BlogPost.find_by(id: params[:id])
  if blog_post
    blog_post.destroy
    render json: { message: "Blog post deleted successfully" }, status: :ok
  else
    render json: { error: "Blog post not found" }, status: :not_found
  end
end
  
private
#strong parameters - allow only safe fields from the request  
def blog_post_params
  params.require(:blog_post).permit(:title, :body, :image_url,   tag_names: [])
  end
end
  