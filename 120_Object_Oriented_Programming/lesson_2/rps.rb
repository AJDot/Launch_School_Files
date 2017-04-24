def prompt(msg)
  puts "=> #{msg}"
end

class Move
  VALUES = %w(rock paper scissors).freeze

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

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?)
  end

  def <(other)
    (rock? && other.paper?) ||
      (paper? && other.scissors?) ||
      (scissors? && other.rock?)
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
      prompt 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      break if Move::VALUES.include? choice
      prompt 'sorry, invalid choice.'
    end
    self.move = Move.new(choice)
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
    prompt '---------------------------------'
    prompt 'Welcome to Rock, Paper, Scissors!'
    prompt '---------------------------------'
  end

  def display_goodbye_message
    prompt '---------------------------------------------------'
    prompt 'Thanks for playing Rock, Paper, Scissors. Good bye!'
    prompt '---------------------------------------------------'
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
    prompt 'SCORE'
    prompt "#{human.name}: #{human.score} " \
    "#{computer.name}: #{computer.score}\n\n"
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
