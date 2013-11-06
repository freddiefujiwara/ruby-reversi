require "reversi/version"

class Reversi
  attr_reader :board
  attr_reader :size
  def initialize(size)
      @size = size
      @board = Array.new size + 2
      @board.each_with_index do |arr,y|
          @board[y] = Array.new size + 2
          @board[y].each_with_index do |arr,x|
            if 0 == y or size + 1 == y or 0 == x or size + 1 == x
                @board[y][x] = :wall
            elsif (size/2 == y and size/2   == x)   or (size/2+1 == y and size/2+1 == x)
                @board[y][x] = :white
            elsif (size/2 == y and size/2+1 == x)   or (size/2+1 == y and size/2   == x)
                @board[y][x] = :black
            else
                @board[y][x] = :blank
            end
          end
      end
  end

  def to_s
      str = ""
      @board.each_with_index do |arr,y|
          @board[y].each_with_index do |arr,x|
              case @board[y][x]
              when :wall
                  str << "#"
              when :white
                  str << "o"
              when :black
                  str << "x"
              when :blank
                  str << " "
              end
          end
          str << "\n"
      end
      str
  end

  def put(color,x,y)
      return unless 1 <= x and x <= @size
      return unless 1 <= y and y <= @size
      return unless @board[y][x] == :blank
      @board[y][x] = color
  end
end
