class SpiritualReminder < ApplicationRecord
  belongs_to :user

  REMINDER_TYPES = %w[
    daily_verse
    tithe_reminder
    offering_reminder
    prayer_reminder
    gratitude_reminder
    financial_wisdom
    stewardship_tip
  ].freeze

  FREQUENCIES = %w[daily weekly monthly].freeze

  validates :reminder_type, inclusion: { in: REMINDER_TYPES }
  validates :frequency, inclusion: { in: FREQUENCIES }
  validates :active, inclusion: { in: [true, false] }

  scope :active, -> { where(active: true) }
  scope :by_type, ->(type) { where(reminder_type: type) }
  scope :due_today, -> { where('next_reminder_date <= ?', Date.current) }

  after_create :set_next_reminder_date

  def should_send_reminder?
    active? && next_reminder_date <= Date.current
  end

  def send_reminder!
    return unless should_send_reminder?

    content = generate_reminder_content

    # Aqui você pode adicionar lógica para enviar e-mail ou notificação
    # Por exemplo: ReminderMailer.send_reminder(user, content).deliver_later

    update_next_reminder_date!
    content
  end

  def generate_reminder_content
    case reminder_type
    when 'daily_verse'
      verse = BiblicalReference.daily_verse
      {
        title: 'Versículo do Dia',
        content: "#{verse.verse_reference}: #{verse.verse_text}"
      }
    when 'tithe_reminder'
      income = user.transactions.income.by_month(Date.current).sum(:amount)
      suggested = Transaction.calculate_suggested_tithe(income)
      {
        title: 'Lembrete de Dízimo',
        content: "Sua receita este mês foi de R$ #{income}. O dízimo sugerido é R$ #{suggested}. 'Honra ao Senhor com teus bens' - Provérbios 3:9"
      }
    when 'offering_reminder'
      {
        title: 'Tempo de Ofertar',
        content: "Lembre-se: 'Deus ama quem dá com alegria' - 2 Coríntios 9:7. Considere abençoar alguém hoje!"
      }
    when 'prayer_reminder'
      {
        title: 'Momento de Oração',
        content: 'Ore por suas finanças e peça sabedoria ao Senhor para administrá-las.'
      }
    when 'gratitude_reminder'
      blessings_count = user.transactions.income.count
      {
        title: 'Seja Grato',
        content: "Você recebeu #{blessings_count} bênçãos financeiras. 'Em tudo dai graças' - 1 Tessalonicenses 5:18"
      }
    when 'financial_wisdom'
      verse = BiblicalReference.verse_for_topic('sabedoria_financeira')
      {
        title: 'Sabedoria Financeira',
        content: verse ? "#{verse.verse_reference}: #{verse.verse_text}" : 'Busque sabedoria para administrar bem seus recursos.'
      }
    when 'stewardship_tip'
      tips = [
        'Faça um orçamento mensal e honre a Deus com as primícias.',
        'Evite dívidas desnecessárias. "O que toma emprestado é servo do que empresta" - Provérbios 22:7',
        'Poupe para o futuro. "O homem prudente prevê o mal e se esconde" - Provérbios 22:3',
        'Seja generoso. "Mais bem-aventurado é dar do que receber" - Atos 20:35',
        'Invista em coisas eternas. Faça tesouros no céu!'
      ]
      {
        title: 'Dica de Mordomia',
        content: tips.sample
      }
    end
  end

  private

  def set_next_reminder_date
    self.next_reminder_date = calculate_next_date
    save
  end

  def update_next_reminder_date!
    update!(
      next_reminder_date: calculate_next_date,
      last_sent_at: Time.current
    )
  end

  def calculate_next_date
    case frequency
    when 'daily'
      Date.current + 1.day
    when 'weekly'
      Date.current + 1.week
    when 'monthly'
      Date.current + 1.month
    else
      Date.current + 1.day
    end
  end
end