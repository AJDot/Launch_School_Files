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

class Move
  VALUES = %w(rock paper scissors Spock lizard).freeze
  WINS = {
    'rock' => %w(scissors lizard),
    'paper' => %w(rock Spock),
    'scissors' => %w(paper lizard),
    'Spock' => %w(rock scissors),
    'lizard' => %w(paper Spock)
  }.freeze

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'Spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def >(other)
    WINS[@value].include?(other.to_s)
  end

  def <(other)
    WINS[other.to_s].include?(@value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end
end

class Human < Player
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
      break if valid_choices.keys.include? choice
      prompt 'sorry, invalid choice.'
    end
    self.move = Move.new(valid_choices[choice])
  end

  private

  def valid_choices
    { 'rock' => 'rock', 'r' => 'rock', 'R' => 'rock',
      'paper' => 'paper', 'p' => 'paper', 'P' => 'paper',
      'scissors' => 'scissors', 's' => 'scissors',
      'Spock' => 'Spock', 'S' => 'Spock',
      'lizard' => 'lizard', 'l' => 'lizard', 'L' => 'lizard' }
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Score
  attr_reader :value

  def initialize
    @value = 0
  end

  def reset
    @value = 0
  end

  def ==(other)
    @value == other
  end

  def +(other)
    @value += other
    self
  end

  def to_s
    @value.to_s
  end
end

# Game Orchestration Engine
class RPSGame
  MAX_SCORE = 3

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  private

  def display_welcome_message
    prompt '------------------------------------------------'
    prompt 'Welcome to Rock, Paper, Scissors, Spock, Lizard!'
    prompt "First to #{MAX_SCORE} wins!"
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

  def display_winner
    if human.move > computer.move
      prompt "#{human.name} won!"
    elsif human.move < computer.move
      prompt "#{computer.name} won!"
    else
      prompt "It's a tie!"
    end
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_score
    prompt '------------Score------------'
    prompt "#{human.name.to_s.center(11)} |||||" \
    "#{computer.name.to_s.center(11)}"
    prompt "#{format('%7.3d', human.score.value)}" \
    "#{format('%18.3d', computer.score.value)}\n\n"
  end

  def reset_scores
    human.score.reset
    computer.score.reset
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
    human.choose
    computer.choose
    display_moves
    display_winner
    update_score
    display_score
  end

  public

  def play
    display_welcome_message
    loop do
      play_round until [human.score, computer.score].include? MAX_SCORE
      break unless play_again?
      reset_scores
    end
    display_goodbye_message
  end
end

RPSGame.new.play
