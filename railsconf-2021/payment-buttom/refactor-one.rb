def save
  purchase.transaction do
    @purchase.lock!

    if !@purchase.in_progress? &&
       !@purchase.completed? &&
        @purchase.shipping_info.valid? &&
        @purchase.payment_info.valid?

      @purchase.update!(in_progress: true)
      PaymentAttemptJob.perform_later(@purchase)

      true
    else
      false
    end
  end
end

class PaymentAttemptJob < ApplicationJob
  def perform(purchase)
    BillingService.charge!(amount: @purchase.amount, card: @purchase.card)
    InventoryService.track!(@purchase)
    FulfillmentService.notify!(@purchase)
    @purchase.update!(in_progress: false, completed: true)
  end
end


class PurchaseAttemptsController < ApplicationController
  def show
    @purchase = Purchase.find_by!(cart_id: session[:cart_id])

    if @purchase.completed?
      redirect_to purchase_confirmations_path(@purchase)
    else
      render :edit
    end
  end
end
