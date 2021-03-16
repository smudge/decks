class PurchasesController < ApplicationController
  def create
    @purchase = Purchase.new(
      order: Order.find_by!(cart_id: session[:cart_id])
    )

    if @purchase.save
      redirect_to confirmations_path(@purchase.order)
    else
      render :edit
    end
  end
end

class PurchaseAttempt
  include ActiveModel::Model

  attr_accessor :purchase

  def save
    # ...
  end
end

def save
  if purchase.shipping_info.valid? && purchase.payment_info.valid?
    BillingService.charge!(amount: purchase.amount, card: purchase.card)
    purchase.update!(completed: true)
    InventoryService.track!(purchase)
    FulfillmentService.notify!(purchase)

    true
  else
    false
  end
end
