def save
  from_account.balance = from_account.balance - amount
  to_account.balance = to_account.balance + amount

  if from_account.valid? && to_account.valid?
    ActiveRecord::Base.transaction do
      from_account.save!
      to_account.save!
    end
    TransferMailer.with(account: from_account).outbound_confirm.deliver_now
    TransferMailer.with(account: to_account).inbound_confirm.deliver_now

    true
  else
    false
  end
end
