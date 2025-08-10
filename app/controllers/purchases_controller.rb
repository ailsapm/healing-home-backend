class PurchasesController < ApplicationController
  #authorize_request and authorize_admin! defined in application_controller
  #ensure user is authenticated before accessing any action
  before_action :authorize_request
  #admin only access to index (view all purchases) or comp (mark a purchase as complimentary)
  before_action :authorize_admin!, only: [:index, :comp]

  # POST /purchases - allow authenticated user to purchase a course
  def create
    # Build new purchase associated with current user, merge in current time as 'purchased_at' timestamp
    purchase = current_user.purchases.build(purchase_params.merge(purchased_at: Time.current))

    #if purchase valid and saved, return success message and data
    if purchase.save
      render json: { message: "Purchase successful", purchase: purchase }, status: :created
    else
       #if not, return validation error msg
      render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /purchases (admin only) - fetch & return all purchases, incl associated user & course data
  def index
    purchases = Purchase.includes(:user, :course).all
    render json: purchases, status: :ok
  end

  # PATCH /purchases/:id/comp - let admin comp a course- set price to zero and mark it as manual comp
  def comp
    purchase = Purchase.find(params[:id])
    #update purchase to show it was comped (free)
    if purchase.update(price_paid: 0, payment_provider: "comped", provider_transaction_id: "manual_comp")
      render json: { message: "Course comped successfully", purchase: purchase }, status: :ok
    else
      render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    # Strong parameters - only permit allowed attributes
  def purchase_params
    params.require(:purchase).permit(:course_id, :price_paid, :payment_provider, :provider_transaction_id)
  end
end
