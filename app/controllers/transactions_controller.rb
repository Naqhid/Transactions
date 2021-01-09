class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      @transaction.transaction_groups.create(show_group_id)
      redirect_to user_transaction_path(current_user, @transaction), notice: 'You successfully created a new transaction.'
    else
      render 'new'
    end
  end

  def show; end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end

  def show_group_id
    params.require(:transaction).permit(:group_id)
  end
end