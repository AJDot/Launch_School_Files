# The eight queens puzzle is based on the classic strategy games problem which is in this case putting eight chess queens on an 8x8 chessboard such that none of them is able to cpature any other using the standard chess queen's moves. The color of the queens is meaningless in this puzzle, and any queen is assumed to be able to attack any other. Thus, a solution requires that no two queens share the same row, column, or diagonal.

# Find the total number of all possible board positions to this puzzle.
require 'pry'
def find_answer(n_queens)
  template = (0...n_queens).to_a
  possibilities = template.permutation(template.size).to_a

  possibilities.map do |possibility|
    it_works = 0.upto(template.size - 2) do |x|
      y = possibility[x]

      other_queens = possibility.each_with_index.select do |(_, other_x)|
        other_x > x
      end
      break false if queen_can_kill?([x, y], other_queens)
      true
    end
    it_works ? 1 : 0
  end.reduce(:+)
end

def queen_can_kill?(current, others)
  x, y = current
  others.any? do |other_y, other_x|
    (x - other_x).abs == (y - other_y).abs
  end
end

# find answer for 1x1 to 10x10 board
(1..10).each do |n_queens|
  start = Time.now
  puts "#{n_queens}x#{n_queens}: #{find_answer(n_queens)} : #{Time.now - start}"
end
