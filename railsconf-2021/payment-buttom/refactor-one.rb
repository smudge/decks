def save
  order.transaction do
    order.lock!

    if !order.in_progress? && order.shipping_info.valid? && order.payment_info.valid?

      order.update!(in_progress: true)
      PaymentAttemptJob.perform_later(order)

      true
    else
      false
    end
  end
end

class PaymentAttemptJob < ApplicationJob
  def perform(order)
    BillingAPI.charge!(order)
    order.update!(completed: true)
    FulfillmentAPI.notify!(order)
  end
end

class PurchasesController < ApplicationController
  def create
    # ...
  end

  def show
    @order = Order.find_by!(cart_id: session[:cart_id])

    if @order.completed?
      redirect_to purchase_confirmations_path(@order)
    else
      render :edit
    end
  end
end
