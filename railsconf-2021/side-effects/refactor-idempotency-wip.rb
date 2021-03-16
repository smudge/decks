def save!
    charge = ExternalProcessor::Charge.create!(
      {
        amount: subscription.amount.cents,
        card_id: subscription.card_id
      },
      idempotency_key: idempotency_key
    )
    subscription.payments.where(
      external_charge_id: charge.id
    ).first_or_create!
  end
end

class MonthlyCharge
  include ActiveModel::Model

  attr_accessor :subscription, :date, :idempotency_key

  def save!
    # ...
  end
end

class SubscriptionProcessingJob < ApplicationJob
  def perform(subscription, date, idempotency_key)
    MonthlyCharge.new(
      subscription: subscription,
      date: date,
      idempotency_key: idempotency_key,
    ).save!
  end
end
