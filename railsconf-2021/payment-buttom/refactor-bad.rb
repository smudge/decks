
def save
  @purchase.transaction do
    @purchase.lock!

    if !@purchase.completed? &&
        @purchase.shipping_info.valid? &&
        @purchase.payment_info.valid?

      BillingService.charge!(amount: @purchase.amount, card: @purchase.card)
      @purchase.update!(completed: true)
      InventoryService.track!(@purchase)
      FulfillmentService.notify!(@purchase)

      true
    else
      false
    end
  end
end
