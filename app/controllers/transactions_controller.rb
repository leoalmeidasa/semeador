class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[edit update destroy]

  def index
    @transactions = current_user.transactions.includes(:category).order(date: :desc)
    @balance = current_user.transactions.sum("CASE WHEN transaction_type = 0 THEN amount ELSE -amount END")
  end

  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to transactions_path, notice: "Transação criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def edit; end

  def update
    if @transaction.update(transaction_params)
      redirect_to transactions_path, notice: "Transação atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path, notice: "Transação removida com sucesso."
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:title, :amount, :date, :transaction_type, :category_id)
  end
end
