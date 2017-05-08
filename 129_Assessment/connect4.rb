# Introduction
#
#  	We all love to play games especially as children. I have fond memories playing Connect 4 with my brother so decided to create this Kata based on the classic game. Connect 4 is known as several names such as “Four in a Row” and “Captain’s Mistress" but was made popular by Hasbro MB Games
#
# Connect 4
# Task
#
#  	The game consists of a grid (7 columns and 6 rows) and two players that take turns to drop their discs. The pieces fall straight down, occupying the next available space within the column. The objective of the game is to be the first to form a horizontal, vertical, or diagonal line of four of one's own discs. Your task is to create a Class called Connect4 that has a method called play which takes one argument for the column where the player is going to place their disc.
#
# Rules
#
#  	If a player successfully has 4 discs horizontally, vertically or diagonally then you should return "Player n wins!” where n is either 1 or 2.
#
# If a player attempts to place a disc in a column that is full then you should return ”Column full!” and the next move must be taken by the same player.
#
# If the game has been won by a player, any following moves should return ”Game has finished!”.
#
# Any other move should return ”Player n has a turn” where n is either 1 or 2.
#
# Player 1 starts the game every time and alternates with player 2.
#
# The columns are numbered 0-6 left to right.
#
# Good luck and enjoy!
#

# Description
# Connect 4 is a 2-player game consisting of a 6x7 grid where players take turns marking the lowest unoccupied square in a column. The first player to mark 4 squares in a row wins.

# Nouns: grid, player, square, column
# Verbs: play, mark

# Grid
# Square
# Player
# - mark
# - play

require 'pry'

module Formatting
  def clear_screen
    system('clear') || system('cls')
  end

  def press_enter_to_continue
    puts "Press ENTER to continue..."
    gets
  end

  def join_or(array)
    case array.size
    when 0 then ''
    when 1 then array.first
    when 2 then "#{array.first} or #{array.last}"
    else
      result = "#{array[0..-2].join(', ')}, or #{array.last}"
    end
  end
end

class Grid
  attr_reader :squares

  def initialize
    # model the 6x7 grid using 'squares'
    # probably using a hash of square object to keep track of them
    @squares = {}
    (1..6).to_a.product((1..7).to_a).each do |row, column|
      @squares[[row, column]] = Square.new
    end
  end

  def display
    puts "+---+---+---+---+---+---+---+"
    puts "| #{squares[[6, 1]]} | #{squares[[6, 2]]} | #{squares[[6, 3]]} | #{squares[[6, 4]]} | #{squares[[6, 5]]} | #{squares[[6, 6]]} | #{squares[[6, 7]]} |"
    puts "|---|---|---|---|---|---|---|"
    puts "| #{squares[[5, 1]]} | #{squares[[5, 2]]} | #{squares[[5, 3]]} | #{squares[[5, 4]]} | #{squares[[5, 5]]} | #{squares[[5, 6]]} | #{squares[[5, 7]]} |"
    puts "|---|---|---|---|---|---|---|"
    puts "| #{squares[[4, 1]]} | #{squares[[4, 2]]} | #{squares[[4, 3]]} | #{squares[[4, 4]]} | #{squares[[4, 5]]} | #{squares[[4, 6]]} | #{squares[[4, 7]]} |"
    puts "|---|---|---|---|---|---|---|"
    puts "| #{squares[[3, 1]]} | #{squares[[3, 2]]} | #{squares[[3, 3]]} | #{squares[[3, 4]]} | #{squares[[3, 5]]} | #{squares[[3, 6]]} | #{squares[[3, 7]]} |"
    puts "|---|---|---|---|---|---|---|"
    puts "| #{squares[[2, 1]]} | #{squares[[2, 2]]} | #{squares[[2, 3]]} | #{squares[[2, 4]]} | #{squares[[2, 5]]} | #{squares[[2, 6]]} | #{squares[[2, 7]]} |"
    puts "|---|---|---|---|---|---|---|"
    puts "| #{squares[[1, 1]]} | #{squares[[1, 2]]} | #{squares[[1, 3]]} | #{squares[[1, 4]]} | #{squares[[1, 5]]} | #{squares[[1, 6]]} | #{squares[[1, 7]]} |"
    puts "+---+---+---+---+---+---+---+"
  end

  def [](row, col)
    squares[[row, col]]
  end

  def next_row(col)
    (1..7).each do |row|
      return row if squares[[row, col]].marker == Square::INITIAL_MARKER
    end
  end

  def available_cols
    result = []
    (1..7).each do |col|
      result << col if squares[[6, col]].marker == Square::INITIAL_MARKER
    end
    result
  end

  def full?
    available_cols.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    winning_lines.each do |line|
      squares = @squares.values_at(*line)
      next unless squares.select(&:marked?).count == 4
        markers = squares.collect(&:marker)
        return squares.first.marker if markers.min == markers.max
    end
    nil
  end

  def winning_lines
    result = []
    # Get all winning lines horizontal
    (1..6).each do |row|
      (1..4).each do |col|
        line = []
        line << [row, col]
        line << [row, col + 1]
        line << [row, col + 2]
        line << [row, col + 3]
        result << line
      end
    end
    # Get all winning lines vertical
    (1..7).each do |col|
      (1..3).each do |row|
        line = []
        line << [row, col]
        line << [row + 1, col]
        line << [row + 2, col]
        line << [row + 3, col]
        result << line
      end
    end
    # Get all winning line diagonal up-right
    (1..3).each do |row|
      (1..4).each do |col|
        line = []
        line << [row, col]
        line << [row + 1, col + 1]
        line << [row + 2, col + 2]
        line << [row + 3, col + 3]
        result << line
      end
    end
    # Get all winning line diagonal down-left
    (4..6).each do |row|
      (1..4).each do |col|
        line = []
        line << [row, col]
        line << [row - 1, col + 1]
        line << [row - 2, col + 2]
        line << [row - 3, col + 3]
        result << line
      end
    end
    result
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    # keep track of the marker in this square
    @marker = marker
  end

  def marked?
    @marker != INITIAL_MARKER
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :name

  def initialize
    # set player's name, marker
    set_name
  end

  def set_name
    name = nil
    loop do
      name = gets.chomp.strip
      break unless name.empty?
      puts "Sorry, you must enter a value."
    end
    @name = name
  end
end

class Connect4
  include Formatting

  attr_reader :grid, :player1, :player2

  PLAYER1_MARKER = 'X'
  PLAYER2_MARKER = 'O'

  def initialize
    # start the grid and each player
    @grid = Grid.new
    puts "Player 1, what is your name?"
    @player1 = Player.new
    puts "Player 2, what is your name?"
    @player2 = Player.new
  end

  def play
    clear_screen
    display_welcome_message
    press_enter_to_continue
    loop do
      clear_screen
      display_grid
      first_player_moves
      break if grid.someone_won? || grid.full?
      second_player_moves
      break if grid.someone_won? || grid.full?
    end
    display_grid
    display_result
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to Connect 4!"
    puts <<~HEREDOC
      Connect 4 is a 2-player game consisting of a 6x7 grid where players take
      turns marking the lowest unoccupied square in a column. The first player
      to mark 4 squares in a row wins.
    HEREDOC
  end

  def display_grid
    grid.display
  end

  def first_player_moves
    available_cols = grid.available_cols
    choice = nil
    loop do
      puts "Choose a column (#{join_or(available_cols)}):"
      choice = gets.chomp.to_i
      break if available_cols.include? choice
      puts "Sorry, must choose from available columns."
    end

    grid[next_row_in_col(choice), choice].marker = PLAYER1_MARKER
  end

  def second_player_moves
    choice = grid.available_cols.sample

    grid[next_row_in_col(choice), choice].marker = PLAYER2_MARKER
  end

  def display_result
    return puts "It's a draw" if grid.full?
    case grid.winning_marker
    when PLAYER1_MARKER
      puts "#{player1.name} won!"
    when PLAYER2_MARKER
      puts "#{player2.name} won!"
    end
  end

  def display_goodbye_message
    puts "Thank you for playing Connect 4! Goodbye!"
  end

  def next_row_in_col(col)
    (1..7).each do |row|
      return row if grid[row, col].marker == Square::INITIAL_MARKER
    end
  end
end

game = Connect4.new
game.play
