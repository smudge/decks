def save
  order.transaction do
    order.lock!

    if !order.completed? &&
        order.shipping_info.valid? &&
        order.payment_info.valid?

      BillingAPI.charge!(order)
      order.update!(completed: true)
      FulfillmentAPI.notify!(order)

      true
    else
      false
    end
  end
end
