require 'colored'

module TicTacToe
  class Player 
    attr_accessor :symbol
    def initialize(symbol)
      @symbol = symbol
    end
  end

  class Board 
    attr_reader :spaces
    def initialize
      @spaces = Array.new(9)
    end

    def to_s
      output = ""
      0.upto(8) do |position|
        output << "#{@spaces[position] || position}"
        case position % 3 
        when 0, 1 then output << " | "
        when 2 then output << "\n-----------\n" unless position == 8
        end
      end
      output
    end

    def space_free?(position)
      @spaces[position].nil?
    end

    def place_symbol(cell, sym)
      @spaces[cell] = sym
    end

    def winner
      WINNING_COMBOS.any? do |set|
        symbols = set.map {|position| @spaces[position]}
        if symbols[0] == symbols[1] && symbols[1] == symbols[2]
          symbols[0] unless symbols[0].nil?
        end
      end
    end

    def tie?
      return !@spaces.include?(nil) && !winner
    end

    private

    WINNING_COMBOS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  class Game 
    attr_reader :spaces
    def initialize
      @board = Board.new
    end

    def play_game
      @player1 = Player.new("X")
      @player2 = Player.new("O")
      puts @board
      @current_turn = 1
      while !@board.winner && !@board.tie?
        move(current_player)
        puts @board
      end
      print_game_result
    end

    private

    def move(player)
      puts "Where would you like to move 'player #{player.symbol}'?".red
      choice = gets.chomp.to_i
      if @board.space_free?(choice)
        @board.place_symbol(choice, player.symbol)
        @current_turn += 1
        puts "Player #{player.symbol}'s move:".green 
      else
        puts "Space unavailable! Please select another cell"
      end
    end

    def print_game_result
      if @board.winner
        @current_turn += 1
        puts "Player #{current_player.symbol} wins!"
        puts "Game over"
      else
        puts "It's a Draw!".cyan 
      end
    end
     
    def current_player
      @current_turn.even? ? @player2 : @player1
    end
  end
end

def play_again?
  puts "Play again? (yes or no)".yellow
  answer = gets.chomp.downcase
  return answer == "yes"
end

loop do 
  TicTacToe::Game.new.play_game
  unless  play_again?
    puts "Goodbye".cyan.bold
    break
  end
end
   

