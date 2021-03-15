# two variants inlined below, will crop images

def save
  ActiveRecord::Base.transaction do
    from_account.lock!
    to_account.lock!

    from_account.balance = from_account.balance - amount
    to_account.balance = to_account.balance + amount

    if from_account.valid? && to_account.valid?
      from_account.save!
      to_account.save!

      TransferOutbox.create!(account: from_account, mail: 'outbound_confirm')
      TransferOutbox.create!(account: to_account, mail: 'outbound_confirm')

      TransferMailer.with(account: from_account).outbound_confirm.deliver_later
      TransferMailer.with(account: to_account).inbound_confirm.deliver_later

      true
    else
      false
    end
  end
end


