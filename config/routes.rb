Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  #authentication routes
  post "/login", to: "sessions#create"       #log in user - creates new session
  delete "/logout", to: "sessions#destroy"   #log out user - destroys current session
  get "/me", to: "sessions#show"             # get current logged-in user's info
  patch "/me", to: "users#update"            # update current logged-in user's info
  delete "/deactivate", to: "users#deactivate"  #allow current user to deactivate their account

  #user routes
  resources :users, only: [:create, :update, :destroy, :index, :show] do
    member do
      patch 'deactivate'  # /users/:id/deactivate - deactivate a specific user account
      patch 'reactivate'    # PATCH /users/:id/reactivate - reactivate a specific user account
    end
  end


  #blog post routes
  resources :blog_posts, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'by_tag'  # GET /blog_posts/by_tag - filter blog posts by tag - def by_tag in blog_posts_controller
    end
  end

  #recipe routes
  resources :recipes, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'search' # GET /recipes/search - search recipes by query params - def search in recipes_controller
      get 'by_tag' # GET /recipes/by_tag - filter recipes by tag - def by_tag in recipes_controller
    end
  end

  #comment routes
  resources :comments, only: [:create, :update, :destroy, :index]

  #plant routes
  resources :plants, only: [:index, :show, :create, :update, :destroy] do
    collection do
      get 'search'  # GET /plants/serach - search plants by query params
    end
  end

  #course categories routes
  resources :course_categories, only: [:index, :create, :destroy]  #admin can delete if needed

  #courses routes - full CRUD with nested lessons
  resources :courses do
    resources :lessons, only: [:index, :create]  #nested for course-specific lessons
  end

  #lessons routes 
  resources :lessons, only: [:show, :update, :destroy]

  #course progress routes
  resources :course_progresses, only: [:create, :update, :show]

  #lesson completion routes
  resources :lesson_completions, only: [:create]
  
  #subscription routes (allow user to create/view/cancel their subscription)
  resources :subscriptions, only: [:index, :show, :create, :update, :destroy] do
    member do
      patch 'cancel'  #user or admin can cancel a subscription
      patch 'comp' #admin can comp a subscription
    end
  end

  #purchase routes (admin can comp a purchase, users can view theirs)
  resources :purchases, only: [:index, :show, :create, :update, :destroy] do
    member do
      patch 'comp'    #admin can comp a course
    end
  end

end