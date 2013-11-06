require "reversi/version"

class Reversi
  attr_reader :board
  attr_reader :size
  def initialize(size)
      @size = size
      @board = Array.new size + 2
      @board.each_with_index do |arr_y,y|
          @board[y] = Array.new size + 2
          @board[y].each_with_index do |arr_x,x|
            @board[y][x] = :wall if 0 == y or size + 1 == y or 0 == x or size + 1 == x
          end
      end
  end

  # Your code goes here...
end
