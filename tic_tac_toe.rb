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

    def space_available(cell, sym) 
      if spaces[cell].nil?
        spaces[cell] = sym
      else
        puts "Space unavailable"
      end
    end
  end

  class Game < Board
    attr_reader :player1, :player2

    def initialize
      super
      play_game
    end

    def play_game
      @player1 = Player.new("X")
      @player2 = Player.new("O")
      puts Board.new
      @current_turn = 1
      turn
    end

    def move(player)
      while victory != true
        puts "Where would you like to move?"
        choice = gets.chomp.to_i
        space_available(choice, player.symbol)
        puts self
        @current_turn += 1
        turn
      end
    end

    def turn
      @current_turn.even? ? move(@player2) : move(@player1)
    end

    def victory
      #still working on this
    end

  end

end

puts TicTacToe::Game.new
