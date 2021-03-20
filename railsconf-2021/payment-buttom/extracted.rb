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

class Purchase
  include ActiveModel::Model

  attr_accessor :order

  def save
    # ...
  end
end

def save
  if order.shipping_info.valid? && order.payment_info.valid?
    BillingAPI.charge!(order)
    order.update!(completed: true)
    FulfillmentAPI.notify!(order)

    true
  else
    false
  end
end
