def save
  from_account.balance = from_account.balance - amount
  to_account.balance = to_account.balance + amount

  from_account.save && to_account.save
end
