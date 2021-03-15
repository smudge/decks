class TransfersController < ApplicationController
  def create
    @transfer = Transfer.new(
      from_account: current_user.acounts.find(params[:from_account_id]),
      to_account: current_user.acounts.find(params[:to_account_id]),
      amount: params.permit(:amount).fetch(:amount).to_money
    )

    if @transfer.save
      redirect_to transfer_completions_path
    else
      render :new
    end
  end
end

class Transfer
  include ActiveModel::Model

  attr_accessor :from_account, :to_account, :amount

  def save
    # ...
  end
end

def save
  from_account.balance = from_account.balance - amount
  to_account.balance = to_account.balance + amount

  if from_account.save && to_account.save
    TransferMailer.with(account: from_account).outbound_confirm.deliver_now
    TransferMailer.with(account: to_account).inbound_confirm.deliver_now

    true
  else
    false
  end
end
