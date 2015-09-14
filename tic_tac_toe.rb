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
        output << "#{spaces[position] || position}"
        case position % 3 
        when 0, 1 then output << " | "
        when 2 then output << "\n-----------\n" unless position == 8
        end
      end
      output
    end

    def check_space(cell, sym)
      if spaces[cell].nil?
        place_symbol(cell, sym)
        @current_turn += 1
      else
        puts "Space unavailable! Please select another cell"
      end
    end

    def place_symbol(cell, sym)
      spaces[cell] = sym
    end

    WINNING_COMBOS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    def winning_scenarios
      WINNING_COMBOS.each do |set|
        if spaces[set[0]] == spaces[set[1]] && spaces[set[1]] == spaces[set[2]]
          return true unless spaces[set[0]].nil?
        end
      end
      false
    end

    def tie
      if !spaces.include?(nil) && !winning_scenarios
        return true
      end
    end

  end

  class Game < Board
    attr_reader :player1, :player2, :symbol

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
      win_message
      tie_message
      play_again
    end

    def move(player)
      while !winning_scenarios && !tie
        puts "Where would you like to move 'player #{player.symbol}'?"
        choice = gets.chomp.to_i
        check_space(choice, player.symbol)
        puts "Player #{player.symbol}'s move:"
        puts self
        turn
      end
    end

    def tie_message
      puts "It's a Draw!" if tie
    end

    def win_message
      puts "Game over!" if winning_scenarios
    end

    def turn
      @current_turn.even? ? move(@player2) : move(@player1)
    end

    def play_again
      puts "Play again? (yes or no)"
      answer = gets.chomp.downcase
      if answer == "yes"
        TicTacToe::Game.new
      else
        puts "Goodbye"
      end
    end

  end

end

TicTacToe::Game.new
