require 'pry'

# Most items displayed to screen
module Displayable
  def display_welcome_message
    prompt '------------------------------------------------'
    prompt 'Welcome to Rock, Paper, Scissors, Spock, Lizard!'
    prompt "First to #{self.class::MAX_SCORE} wins!"
    prompt '------------------------------------------------'
  end

  def display_goodbye_message
    prompt '------------------------------------------------------------------'
    prompt 'Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!'
    prompt '------------------------------------------------------------------'
  end

  def display_moves
    prompt "#{human.name} chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}."
  end

  def display_game_winner
    winner = human.score == self.class::MAX_SCORE ? human : computer
    prompt "#{winner.name} won the game!"
  end

  def display_score
    human_score = human.score
    computer_score = computer.score
    spacing = ' ' * 16

    prompt '---------Round Score---------'
    prompt "#{human_score}#{spacing}#{computer_score}".center(29)
    prompt '---------Game Score----------'
    prompt "#{human_score.game}#{spacing}#{computer_score.game}".center(29)
    prompt ''
  end

  def display_header
    prompt human.display_in_header + '-----' + computer.display_in_header
  end

  def show_display
    clear_screen
    display_moves
    display_winner
    display_header
    display_score
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

# Methods to help format basic objects
module Formatting
  def prompt(msg)
    puts "=> #{msg}"
  end

  def join_or(array)
    case array.size
    when 1
      array.first
    when 2
      "#{array.first} or #{array.last}"
    else
      "#{array[0..-2].join(', ')} or #{array.last}"
    end
  end
end

class Move
  VALUES = %w(rock paper scissors Spock lizard).freeze

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other)
    [Scissors, Lizard].include?(other.class)
  end

  def <(other)
    [Spock, Paper].include?(other.class)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other)
    [Rock, Spock].include?(other.class)
  end

  def <(other)
    [Scissors, Lizard].include?(other.class)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other)
    [Paper, Lizard].include?(other.class)
  end

  def <(other)
    [Rock, Spock].include?(other.class)
  end
end

class Spock < Move
  def initialize
    @value = 'Spock'
  end

  def >(other)
    [Rock, Scissors].include?(other.class)
  end

  def <(other)
    [Paper, Lizard].include?(other.class)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other)
    [Paper, Spock].include?(other.class)
  end

  def <(other)
    [Rock, Scissors].include?(other.class)
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end

  def set_name
    self.name = 'Tie'
  end

  def make_choice(choice)
    self.move = Object.const_get(choice.capitalize).new
  end

  def display_in_header
    name.center(12)
  end

  def to_s
    name
  end
end

class Human < Player
  VALID_INPUTS = { 'rock' => 'Rock', 'r' => 'Rock', 'R' => 'Rock',
      'paper' => 'Paper', 'p' => 'Paper', 'P' => 'Paper',
      'scissors' => 'Scissors', 's' => 'Scissors',
      'Spock' => 'Spock', 'S' => 'Spock',
      'lizard' => 'Lizard', 'l' => 'Lizard', 'L' => 'Lizard' }

  include Formatting

  def set_name
    n = ''
    loop do
      prompt "What's your name?"
      n = gets.chomp.strip
      break unless n.empty?
      prompt 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      prompt "Please choose #{join_or(Move::VALUES)}:"
      choice = gets.chomp
      break if VALID_INPUTS.keys.include? choice
      prompt 'sorry, invalid choice.'
    end
    choice = VALID_INPUTS[choice]
    make_choice(choice)
  end

  private

end

class Computer < Player
  def initialize
    super
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample
    make_choice(choice)
  end
end

# Collaborator class for Player
class Score
  attr_reader :round
  attr_accessor :game

  def initialize
    @round = 0
    @game = 0
  end

  def reset
    @round = 0
  end

  def ==(other)
    @round == other
  end

  def +(other)
    @round += other
    self
  end

  def to_s
    @round.to_s
  end
end

class History
  include Formatting

  attr_reader :human_moves, :computer_moves, :winners, :game_num, :round_num

  def initialize
    @human_moves = []
    @computer_moves = []
    @winners = []
    @game_num = []
    @round_num = []
  end

  def add_human_move(move)
    human_moves.push(move.to_s)
  end

  def add_computer_move(move)
    computer_moves.push(move.to_s)
  end

  def add_winner(winner)
    winners.push(winner.to_s)
  end

  def add_game_num(num)
    game_num.push(num.to_s)
  end

  def add_round_num(num)
    round_num.push(num.to_s)
  end

  def append(human_move, computer_move, winner, game, round)
    add_human_move(human_move)
    add_computer_move(computer_move)
    add_winner(winner)
    add_game_num(game)
    add_round_num(round)
  end

  def format_line(round)
    human_moves[round].center(12) +
      '     ' +
      computer_moves[round].center(12) +
      game_num[round].center(6) +
      round_num[round].center(8) +
      winners[round].center(12)
  end

  def format_history
    result = []
    human_moves.size.times do |round|
      result << format_line(round)
    end
    result
  end

  def display
    prompt '-----------History------------Game--Round-----Winner---'
    format_history.each { |line| prompt line }
    prompt '-------------------------------------------------------'
  end
end

# Game Orchestration Engine
class RPSGame
  include Displayable, Formatting

  MAX_SCORE = 3

  attr_accessor :human, :computer
  attr_reader :history

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @history = History.new
    @game = 1
    @round = 0
  end

  private

  def update_score
    @winner.score += 1 unless @winner.to_s == 'Tie'
  end

  def log_history
    history.append(human.move, computer.move, @winner, @game, @round)
  end

  def display_winner
    msg = @winner.to_s == 'Tie' ? "It's a tie!" : "#{@winner} won the round!"
    prompt msg
  end

  def determine_winner
    human_move = human.move
    computer_move = computer.move
    @winner = if human_move > computer_move
                human
              elsif human_move < computer_move
                computer
              else
                'Tie'
              end
  end

  def next_round
    @round += 1
  end

  def next_game
    human.score.reset
    computer.score.reset
    @game += 1
    @round = 0
  end

  def show_after_game_display
    display_game_winner
    update_game_count
    show_display
    history.display
  end

  def update_game_count
    game_winner = human.score == MAX_SCORE ? human : computer
    game_winner.score.game += 1
  end

  def play_again?
    answer = nil
    loop do
      prompt 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      prompt 'Sorry, must be y or n.'
    end
    answer == 'y'
  end

  def play_round
    next_round
    human.choose
    computer.choose
    determine_winner
    display_winner
    log_history
    update_score
    show_display
    history.display
  end

  public

  def play
    display_welcome_message
    loop do
      play_round until [human.score, computer.score].include? MAX_SCORE
      show_after_game_display
      break unless play_again?
      next_game
    end
    display_goodbye_message
  end
end

RPSGame.new.play
