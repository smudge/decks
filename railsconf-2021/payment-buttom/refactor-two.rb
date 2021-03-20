class PaymentAttemptJob < ApplicationJob
  def perform(order, idempotency_key)
    BillingAPI.charge!(order, idempotency_key)
    order.update!(completed: true)

    FulfillmentJob.notify!(order, idempotency_key)
  end
end

