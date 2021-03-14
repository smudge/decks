class TransfersController < ApplicationController
  def create
    @from_account = current_user.acounts.find(params[:from_account_id])
    @to_account = current_user.acounts.find(params[:to_account_id])
    amount = params.permit(:amount).fetch(:amount).to_money

    @from_account.balance = @from_account.balance - amount
    @to_account.balance = @to_account.balance + amount

    if @from_account.save && @to_account.save
      redirect_to transfer_completions_path
    else
      render :new
    end
  end
end
