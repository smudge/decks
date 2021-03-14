def save
  from_account.balance = from_account.balance - amount
  to_account.balance = to_account.balance + amount

  if from_account.valid? && to_account.valid?
    ActiveRecord::Base.transaction do
      from_account.save!
      to_account.save!
    end

    true
  else
    false
  end
end
