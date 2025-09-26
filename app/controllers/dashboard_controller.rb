class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.order(date: :desc).limit(5)
    @balance = current_user.transactions.sum("CASE WHEN transaction_type = 0 THEN amount ELSE -amount END")

    # Métricas cristãs
    current_month_start = Date.current.beginning_of_month
    current_month_end = Date.current.end_of_month
    current_year_start = Date.current.beginning_of_year
    current_year_end = Date.current.end_of_year

    # Receitas e dízimos do mês
    @monthly_income = current_user.transactions
                                  .income
                                  .by_month(Date.current)
                                  .sum(:amount)

    @monthly_tithes = Transaction.total_tithes_for_period(
      current_user,
      current_month_start,
      current_month_end
    )

    @suggested_tithe = Transaction.calculate_suggested_tithe(@monthly_income)

    @tithe_percentage = Transaction.tithe_percentage_for_period(
      current_user,
      current_month_start,
      current_month_end
    )

    # Estatísticas anuais
    @yearly_tithes = Transaction.total_tithes_for_period(
      current_user,
      current_year_start,
      current_year_end
    )

    @yearly_income = current_user.transactions
                                 .income
                                 .by_year(Date.current)
                                 .sum(:amount)

    # Categorias mais utilizadas
    @top_categories = current_user.transactions
                                  .joins(:category)
                                  .group('categories.name')
                                  .order('sum_amount DESC')
                                  .limit(5)
                                  .sum(:amount)

    # Versículo do dia
    @daily_verse = if defined?(BiblicalReference)
                    BiblicalReference.daily_verse
                  else
                    {
                      verse_reference: "Malaquias 3:10",
                      verse_text: "Trazei todos os dízimos à casa do tesouro, para que haja mantimento na minha casa..."
                    }
                  end

    # Metas financeiras
    @goals = current_user.goals.where('due_date >= ?', Date.current).limit(3) if current_user.respond_to?(:goals)

    # Alertas e lembretes
    @reminders = []

    if @tithe_percentage < 10
      @reminders << {
        type: 'tithe',
        message: "Seu dízimo este mês está em #{@tithe_percentage.round(2)}%. Lembre-se de honrar ao Senhor com suas primícias.",
        priority: 'high'
      }
    end

    if @balance < 0
      @reminders << {
        type: 'balance',
        message: "Seu saldo está negativo. Busque sabedoria para equilibrar suas finanças.",
        priority: 'high'
      }
    end

    # Gráfico de despesas por categoria cristã
    @christian_expenses = current_user.transactions
                                      .expense
                                      .joins(:category)
                                      .where(date: current_month_start..current_month_end)
                                      .where(categories: {
                                        name: ['Dízimo', 'Ofertas', 'Missões', 'Literatura cristã', 'Ajuda ao próximo']
                                      })
                                      .group('categories.name')
                                      .sum(:amount)
  end
end
