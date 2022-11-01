class Game
  require_relative 'card'
  require_relative 'player'

  attr_accessor :deck, :bank
  attr_reader :user, :dealer

  def prepare_game
    puts 'Enter your name:'
    player_name = gets.chomp
    @user = Player.new(player_name)
    @dealer = Player.new('Dealer')
    @bank = 0
    new_deck
  end

  def new_deck
    @deck = creation_deck.shuffle
    card_distribution
    take_bets
    start
  end

  def start
    loop do
      user_move
    end
  end

  def user_move
    puts '======================================'
    puts 'You bet 10$'
    print 'Your cards: '
    hand(user)
    print "card value: #{card_sum(user)} "
    puts "Your bankroll: #{user.bankroll}$"
    print "Dealer's cards: "
    dealer_hand
    puts "Dealer's bankroll: #{dealer.bankroll}$"
    puts 'Enter 1 for take card'
    puts "Enter 2 for dealer's turn"
    puts 'Enter 3 for open card'
    user_choice = gets.chomp.to_i
    case user_choice
    when 1
      hit(@user)
    when 2
      dealer_move
    when 3
      open_hand
    end
  end

  def dealer_move
    if card_sum(dealer) < 17
      hit(dealer)
    else
      user_move
    end
  end

  def creation_deck
    [].tap do |arr|
      CARDS.each do |n, v|
        CARD_SUIT.each do |s|
          arr << Card.new(s, n, v)
        end
      end
    end
  end

  def card_distribution
    user.hand += deck.shift(2)
    dealer.hand += deck.shift(2)
  end

  def hit(player)
    player.hand << deck.shift unless player.hand.size > 2
  end

  def card_sum(player)
    sum = 0
    player.hand.each { |card| sum += card.value }
    player.hand.each { |card| sum -= 10 if card.name == 'A' && sum > 21 }
    sum
  end

  def hand(player)
    player.hand.each { |a| print "#{a.name}#{a.card_suit} " }
  end

  def dealer_hand
    dealer.hand.each { print '* ' }
  end

  def open_hand
    puts '======================================'
    print "Dealer's cards: "
    hand(dealer)
    puts "card value: #{card_sum(dealer)}"
    puts '======================================'
    if card_sum(user) > 21 || card_sum(user) < card_sum(dealer)
      user_lost
    elsif card_sum(dealer) > 21 || card_sum(user) > card_sum(dealer)
      user_win
    elsif card_sum(user) == card_sum(dealer)
      tie
    end
  end

  def user_lost
    puts 'You lose'
    dealer.bankroll += bank
    clear
    next_game?
  end

  def user_win
    puts 'You win'
    user.bankroll += bank
    clear
    next_game?
  end

  def tie
    puts 'Tie'
    dealer.bankroll += bank / 2
    user.bankroll += bank / 2
    clear
    next_game?
  end

  def take_bets
    @bank += user.bet
    @bank += dealer.bet
  end

  def clear
    user.hand.clear
    dealer.hand.clear
    @bank = 0
    @deck.clear
  end

  def next_game?
    puts '======================================'
    puts 'Enter 1 if you want to play next game'
    puts 'Enter 2 if you want to exit'
    puts '======================================'
    user_choice = gets.chomp.to_i
    case user_choice
    when 1
      new_deck
    when 2
      abort
    end
  end
end
