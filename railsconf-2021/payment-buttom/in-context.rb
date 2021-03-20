class PurchasesController < ApplicationController
  def create
    @order = Order.find_by!(cart_id: session[:cart_id])

    if @order.shipping_info.valid? && @order.payment_info.valid?
      BillingAPI.charge!(@order)
      @order.update!(completed: true)
      FulfillmentAPI.notify!(@order)

      redirect_to confirmations_path(@order)
    else
      render :edit
    end
  end
end
