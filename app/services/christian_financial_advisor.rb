class ChristianFinancialAdvisor
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def generate_monthly_report
    {
      overview: monthly_overview,
      tithe_analysis: analyze_tithing,
      spending_analysis: analyze_spending,
      biblical_guidance: get_biblical_guidance,
      recommendations: generate_recommendations,
      prayer_points: generate_prayer_points
    }
  end

  private

  def monthly_overview
    current_month = Date.current
    income = user.transactions.income.by_month(current_month).sum(:amount)
    expenses = user.transactions.expense.by_month(current_month).sum(:amount)
    tithes = user.transactions.tithes_and_offerings.by_month(current_month).sum(:amount)

    {
      total_income: income,
      total_expenses: expenses,
      total_tithes_offerings: tithes,
      net_balance: income - expenses,
      savings_rate: calculate_savings_rate(income, expenses)
    }
  end

  def analyze_tithing
    current_month = Date.current
    income = user.transactions.income.by_month(current_month).sum(:amount)
    tithes = user.transactions.tithes_and_offerings.by_month(current_month).sum(:amount)
    percentage = income > 0 ? (tithes / income * 100).round(2) : 0

    {
      total_given: tithes,
      percentage_of_income: percentage,
      suggested_amount: income * 0.1,
      faithfulness_level: determine_faithfulness_level(percentage),
      blessing_promise: get_blessing_promise(percentage)
    }
  end

  def analyze_spending
    current_month = Date.current
    expenses_by_category = user.transactions
                               .expense
                               .joins(:category)
                               .where(date: current_month.beginning_of_month..current_month.end_of_month)
                               .group('categories.name')
                               .sum(:amount)

    total_expenses = expenses_by_category.values.sum

    categories_analysis = expenses_by_category.map do |category, amount|
      percentage = total_expenses > 0 ? (amount / total_expenses * 100).round(2) : 0
      {
        category: category,
        amount: amount,
        percentage: percentage,
        assessment: assess_category_spending(category, percentage)
      }
    end

    {
      by_category: categories_analysis,
      total: total_expenses,
      kingdom_first_percentage: calculate_kingdom_percentage(expenses_by_category)
    }
  end

  def get_biblical_guidance
    topics = determine_relevant_topics
    verses = topics.map do |topic|
      BiblicalReference.verse_for_topic(topic)
    end.compact

    {
      relevant_verses: verses,
      monthly_theme: determine_monthly_theme,
      wisdom_principle: get_wisdom_principle
    }
  end

  def generate_recommendations
    recommendations = []
    overview = monthly_overview
    tithe_data = analyze_tithing

    if tithe_data[:percentage_of_income] < 10
      recommendations << {
        priority: 'high',
        area: 'Dízimos',
        recommendation: 'Considere aumentar suas contribuições para honrar ao Senhor com as primícias.',
        action_steps: [
          'Revise seu orçamento para priorizar o dízimo',
          'Ore pedindo fé para confiar em Deus com suas finanças',
          'Comece aumentando gradualmente até alcançar 10%'
        ]
      }
    end

    if overview[:savings_rate] < 10
      recommendations << {
        priority: 'medium',
        area: 'Poupança',
        recommendation: 'Procure poupar pelo menos 10% de sua renda.',
        action_steps: [
          'Automatize suas economias',
          'Reduza gastos supérfluos',
          'Estabeleça metas de poupança claras'
        ]
      }
    end

    if has_debt?
      recommendations << {
        priority: 'high',
        area: 'Dívidas',
        recommendation: 'Trabalhe para quitar suas dívidas e alcançar liberdade financeira.',
        action_steps: [
          'Liste todas as suas dívidas',
          'Priorize o pagamento das menores primeiro',
          'Evite novas dívidas',
          'Ore por provisão e sabedoria'
        ]
      }
    end

    recommendations
  end

  def generate_prayer_points
    [
      'Agradeça a Deus por toda provisão recebida',
      'Peça sabedoria para administrar os recursos com fidelidade',
      'Ore por contentamento e contra a ganância',
      'Interceda por oportunidades de abençoar outros',
      'Busque direção divina para decisões financeiras importantes',
      'Declare confiança na provisão de Deus'
    ]
  end

  def calculate_savings_rate(income, expenses)
    return 0 if income <= 0
    ((income - expenses) / income * 100).round(2)
  end

  def determine_faithfulness_level(percentage)
    case percentage
    when 0...5 then 'Precisa melhorar - Deus ama quem dá com alegria'
    when 5...10 then 'Caminhando bem - Continue crescendo em fidelidade'
    when 10...15 then 'Fiel - Você honra ao Senhor com suas primícias'
    else 'Generoso - Sua generosidade reflete o coração de Deus'
    end
  end

  def get_blessing_promise(percentage)
    if percentage >= 10
      'Provai e vede! Deus promete abrir as janelas do céu sobre você! (Malaquias 3:10)'
    else
      'Honre ao Senhor com teus bens e se encherão os teus celeiros (Provérbios 3:9-10)'
    end
  end

  def assess_category_spending(category, percentage)
    christian_categories = ['Dízimo', 'Ofertas', 'Missões', 'Literatura cristã', 'Ajuda ao próximo']

    if christian_categories.include?(category)
      'Investimento no Reino de Deus'
    elsif percentage > 30
      'Considere revisar este gasto'
    elsif percentage > 20
      'Gasto moderado'
    else
      'Gasto equilibrado'
    end
  end

  def calculate_kingdom_percentage(expenses_by_category)
    kingdom_categories = ['Dízimo', 'Ofertas', 'Missões', 'Literatura cristã', 'Ajuda ao próximo', 'Eventos da igreja']
    kingdom_total = expenses_by_category.select { |k, _| kingdom_categories.include?(k) }.values.sum
    total = expenses_by_category.values.sum

    return 0 if total <= 0
    (kingdom_total / total * 100).round(2)
  end

  def determine_relevant_topics
    topics = ['sabedoria_financeira']
    overview = monthly_overview

    topics << 'dizimo' if analyze_tithing[:percentage_of_income] < 10
    topics << 'contentamento' if overview[:net_balance] < 0
    topics << 'generosidade' if overview[:savings_rate] > 20
    topics << 'dividas' if has_debt?
    topics << 'planejamento'

    topics
  end

  def determine_monthly_theme
    month = Date.current.month
    themes = {
      1 => 'Novos começos financeiros com Deus',
      2 => 'Amor e generosidade',
      3 => 'Preparação e planejamento',
      4 => 'Renovação e esperança',
      5 => 'Gratidão e reconhecimento',
      6 => 'Fidelidade no pouco e no muito',
      7 => 'Colheita e multiplicação',
      8 => 'Provisão divina',
      9 => 'Sabedoria e discernimento',
      10 => 'Ações de graças',
      11 => 'Generosidade e partilha',
      12 => 'Reflexão e celebração'
    }

    themes[month]
  end

  def get_wisdom_principle
    principles = [
      'O justo anda na sua integridade; bem-aventurados serão os seus filhos depois dele.',
      'Melhor é o pouco com justiça, do que a abundância de bens com injustiça.',
      'Aquele que é fiel no pouco, também é fiel no muito.',
      'Não ajunteis tesouros na terra, mas ajuntai tesouros no céu.',
      'Buscai primeiro o Reino de Deus e sua justiça, e todas estas coisas vos serão acrescentadas.'
    ]

    principles.sample
  end

  def has_debt?
    # Verifica se existem categorias relacionadas a dívidas
    debt_categories = ['Empréstimos', 'Cartão de crédito', 'Financiamentos', 'Dívidas']
    user.transactions
        .expense
        .joins(:category)
        .where(categories: { name: debt_categories })
        .exists?
  end
end