namespace :scheduled do
  desc "Run at 8am daily via cron"
  task :charge_recurring_subscriptions do
    today = Date.current
    Subscription.where(day: today.day).find_each do |subscription|
      charge = BillingService::Charge.create!(
        amount: subscription.amount.cents,
        card_id: subscription.card_id
      )
      subscription.payment.create!(
        date: today,
        external_charge_id: charge.id
      )
      SubscriptionNotifier.with(payment: payment)
        .charge_confirmation_email.deliver_now
    end
  end
end
