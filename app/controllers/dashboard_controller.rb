class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(date: :desc).limit(5)
    @balance = current_user.transactions.sum("CASE WHEN transaction_type = 0 THEN amount ELSE -amount END")

    @verse = [
      "Provérbios 21:5 – O plano do diligente tende à abundância.",
      "2 Coríntios 9:7 – Deus ama quem dá com alegria.",
      "Lucas 14:28 – Quem de vós, querendo construir uma torre, não se assenta primeiro a calcular os gastos?"
    ].sample
  end
end
