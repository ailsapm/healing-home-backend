class SubscriptionsController < ApplicationController
  #require user to be logged in before any action, authorize_request defined in application_controller
  before_action :authorize_request
  #only admin users allowed to access index and comp - authorize_admin! also defined in application_controller
  before_action :authorize_admin!, only: [:index, :comp]

  # POST /subscriptions
  #build new subscription associated with current logged-in user, merge in `started_at` as the current time
  def create
    subscription = current_user.build_subscription(subscription_params.merge(started_at: Time.current))

    #try to save subscription to database
    if subscription.save
      #if successful respond with success message and subscription data
      render json: { message: "Subscription created", subscription: subscription }, status: :created
    else
      #if it fails return error msg
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /subscriptions - view all subscriptions - admin only
  def index
    #fetch all subscriptions and include associated user data, this way there are only
    #two queries, one to get the subscription and one to get the users
    subscriptions = Subscription.includes(:user).all
    #return list of subscriptions
    render json: subscriptions, status: :ok
  end

  # PATCH /subscriptions/:id/cancel  - cancel current user's subscription
  def cancel
    #find current user's subscription
    subscription = current_user.subscription
    #try to update its status to "cancelled" and set expiry time to now
    if subscription&.update(status: "cancelled", expires_at: Time.current)
      render json: { message: "Subscription cancelled" }, status: :ok
    else
      render json: { error: "Unable to cancel subscription" }, status: :unprocessable_entity
    end
  end

  # PATCH /subscriptions/:id/comp - let admin comp a subscription
  def comp
    #find subscription by id
    subscription = Subscription.find(params[:id])
    #mark it as "comped" with manual payment method
    if subscription.update(status: "comped", payment_provider: "manual", provider_subscription_id: "manual_comp")
      render json: { message: "Subscription comped successfully", subscription: subscription }, status: :ok
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  #strong parameters - only allow specific fields for security
  def subscription_params
    params.require(:subscription).permit(:status, :expires_at, :payment_provider, :provider_subscription_id)
  end
end
