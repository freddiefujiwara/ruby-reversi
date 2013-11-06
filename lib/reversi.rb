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
                @board[y][x] = "#"
            elsif (size/2 == y and size/2   == x)   or (size/2+1 == y and size/2+1 == x)
                @board[y][x] = "W"
            elsif (size/2 == y and size/2+1 == x)   or (size/2+1 == y and size/2   == x)
                @board[y][x] = "B"
            else
                @board[y][x] = " "
            end
          end
      end
  end

  def to_s
      str = ""
      @board.each_with_index do |arr,y|
          @board[y].each_with_index do |arr,x|
              str << @board[y][x]
          end
          str << "\n"
      end
      str
  end

  def put(color,x,y)
      return unless 1 <= x and x <= @size
      return unless 1 <= y and y <= @size
      return unless @board[y][x] == " "
      @board[y][x] = color
  end

  def reverse(color,x,y)
      return unless 1 <= x and x <= @size
      return unless 1 <= y and y <= @size
      return unless @board[y][x] == " "
      enemy = color == "B" ? "W" : "B"
      @board[y][x] = color
      # north
      (y - 1).downto(1).each do |yi|
          if @board[yi][x] == color
              (yi + 1).upto(y - 1).each do |ye|
                  @board[ye][x] = color
              end
              break
          end
          break if @board[yi][x] == " "
      end

      # south
      (y + 1).upto(size).each do |yi|
          if @board[yi][x] == color
              (yi - 1).downto(y + 1).each do |ye|
                  @board[ye][x] = color
              end
              break
          end
          break if @board[yi][x] == " "
      end

      # west
      (x - 1).downto(1).each do |xi|
          if @board[y][xi] == color
              (xi + 1).upto(x - 1).each do |xe|
                  @board[y][xe] = color
              end
              break
          end
          break if @board[y][xi] == " "
      end

      # east
      (x + 1).upto(size).each do |xi|
          if @board[y][xi] == color
              (xi - 1).downto(x + 1).each do |xe|
                  @board[y][xe] = color
              end
              break
          end
          break if @board[y][xi] == " "
      end

      # south east
      xi = x
      yi = y
      walk = []
      [y,x].max.upto(size).each do
        xi += 1
        yi += 1
        walk << {:x => xi,:y => yi}
        if @board[yi][xi] == color
            walk.each do |pos|
                @board[pos[:y]][pos[:x]] = color
            end
            break
        end
        break if @board[yi][xi] == " "
      end

      # north west
      xi = x
      yi = y
      walk = []
      [y,x].min.downto(1).each do
        xi -= 1
        yi -= 1
        walk << {:x => xi,:y => yi}
        if @board[yi][xi] == color
            walk.each do |pos|
                @board[pos[:y]][pos[:x]] = color
            end
            break
        end
        break if @board[yi][xi] == " "
      end
  end
end
