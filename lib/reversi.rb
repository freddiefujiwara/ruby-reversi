require "reversi/version"

class Reversi
    attr_reader :board
    attr_reader :size
    def initialize(size)
        @size = size
        @board = Array.new size + 2
        indexes = (0 .. (@size + 1))
        indexes.each do |y|
            @board[y] = Array.new size + 2
            indexes.each do |x|
                #wall
                if 0 == y or size + 1 == y or 0 == x  or size + 1 == x
                    @board[y][x] = "#"
                #initialize
                elsif (size/2 == y and size/2   == x) or (size/2+1 == y and size/2+1 == x)
                    @board[y][x] = "W"
                elsif (size/2 == y and size/2+1 == x) or (size/2+1 == y and size/2   == x)
                    @board[y][x] = "B"
                #blank
                else
                    @board[y][x] = " "
                end
            end
        end
    end

    def to_s
        str = ""
        indexes = (0 .. (@size + 1))
        indexes.each do |y|
            indexes.each do |x|
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
        # filters
        return unless 1 <= x and x <= @size
        return unless 1 <= y and y <= @size
        return unless @board[y][x] == " "

        opposite = color == "B" ? "W" : "B"
        @board[y][x] = color
        paths = []

        # north
        paths << (y - 1).downto(1).map { |yi| {:x => x , :y => yi } }
        # east
        paths << (x + 1).upto(size).map{ |xi| {:x => xi ,:y => y } }
        # west
        paths << (x - 1).downto(1).map { |xi| {:x => xi ,:y => y } }
        # south
        paths << (y + 1).upto(size).map{ |yi| {:x => x , :y => yi } }

        #south east
        paths << (size - [y,x].max + 1).times.map{ |i| {:x => x + i + 1, :y => y + i + 1} }
        #north west
        paths << ([y,x].min - 2).times.map{ |i| {:x => x - i - 1, :y => y - i - 1} }
        #south west
        paths << [(size - x - 1),(y - 2)].min.times.map{ |i| {:x => x + i + 1, :y => y - i - 1} }
        #north east
        paths << [(size - y - 1),(x - 2)].min.times.map{ |i| {:x => x - i - 1, :y => y + i + 1} }

        paths.each do |path|
            walk = []
            path.each do |xy|
                walk << xy
                if @board[xy[:y]][xy[:x]] == color
                    walk.each do |pos|
                        @board[pos[:y]][pos[:x]] = color
                    end
                    break
                end
                break if @board[xy[:y]][xy[:x]] == " "
            end
        end
    end
end
