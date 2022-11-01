CARD_SUIT = %i[♥ ♣ ♦ ♠].freeze

CARDS = {
  2 => 2,
  3 => 3,
  4 => 4,
  5 => 5,
  6 => 6,
  7 => 7,
  8 => 8,
  9 => 9,
  10 => 10,
  'J' => 10,
  'Q' => 10,
  'K' => 10,
  'A' => 11
}.freeze

class Card
  attr_reader :name, :card_suit, :value

  def initialize(card_suit, name, value)
    @card_suit = card_suit
    @name = name
    @value = value
  end
end
