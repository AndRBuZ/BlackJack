class Player
  attr_accessor :bankroll, :hand
  attr_reader :name

  BET = 10

  def initialize(name)
    @name = name
    @bankroll = 100
    @hand = []
  end

  def bet
    if BET > bankroll
      puts 'Not enought money, GAME OVER'
    else
      self.bankroll -= BET
      BET
    end
  end
end
