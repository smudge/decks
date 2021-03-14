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
