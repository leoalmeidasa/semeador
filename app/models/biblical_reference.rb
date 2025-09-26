class BiblicalReference < ApplicationRecord
  TOPICS = [
    'dizimo',
    'ofertas',
    'prosperidade',
    'sabedoria_financeira',
    'contentamento',
    'generosidade',
    'trabalho',
    'dividas',
    'planejamento'
  ].freeze

  validates :verse_reference, :verse_text, :topic, presence: true
  validates :topic, inclusion: { in: TOPICS }

  scope :by_topic, ->(topic) { where(topic: topic) }
  scope :random, -> { order(Arel.sql('RANDOM()')) }

  def self.daily_verse
    random.first
  end

  def self.verse_for_topic(topic)
    by_topic(topic).random.first
  end
end