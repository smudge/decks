def save
  ActiveRecord::Base.transaction do
    from_account.lock!
    to_account.lock!

    from_account.balance = from_account.balance - amount
    to_account.balance = to_account.balance + amount

    if from_account.valid? && to_account.valid?
      from_account.save!
      to_account.save!

      true
    else
      false
    end
  end
end

