require_relative 'player'

class Game
    def initialize
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @players = [Player.new("X"), Player.new("O")]
      @curr_player = 0
    end
  
    def play
      loop do
        print_board
        puts "#{curr_player}'s turn, enter unmarked number:"
        position = gets.strip.to_i-1
        loop do
          break if unmarked?(position)
          puts "#{curr_player}'s turn, enter unmarked number:"
          position = gets.strip.to_i-1
        end
        mark(position)
        break if win? || draw?
        change_player
      end
    end
  
    private
  
    def mark(position)
      @board[position] = curr_player
    end
  
    def change_player
      @curr_player = (@curr_player + 1) % 2
    end
  
    def print_board
      [0, 3, 6].each { |n|
          puts "#{@board[n]} #{@board[n+1]} #{@board[n+2]}"
      }
    end
  
    def curr_player
      @players[@curr_player].symbol
    end
  
    def win?
      winning_lines = 
        [[0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]]
      result = winning_lines.any? { |line|
          line.all? { |n| @board[n] == curr_player}
      }
      if result
        print_board
        puts "#{curr_player} wins!"
      end
      result
    end
  
    def unmarked?(position)
      @board[position].is_a? Numeric
    end
  
    def draw?
      result = @board.none? { |val| val.is_a? Numeric}
      if result
        print_board
        puts "It's a draw!"
      end
      result
    end
  end
  
  game = Game.new
  game.play