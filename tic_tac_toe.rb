class Player #will choose moves
  attr_accessor :name, :x_or_o

  def initialize(name, x_or_o)
    @name = name
    @x_or_o = x_or_o
  end

end

class Board #will hold the state of the moves
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

  def change_board
    @array[choice] = player_name
  end

  def space_available? 
    if @space[choice].nil?
      return false
    else
      return true
    end
  end

end

class Game #will run game and declare winner. What should this object have? 
  def initialize
    play_game
  end

  def play_game
    player1 = Player.new(player_name(1), 'X')
    player2 = Player.new(player_name(2), 'O')
    puts Board.new
    move
  end

  def player_name(number)
    puts "What is your name, player #{number}?"
    nom = gets.chomp
    puts "Welcome #{nom}!"
  end

  def move
    player1_turn = true
    while victory != true
      puts "Where would you like to move?"
      choice = gets.chomp
      if choice.space_available? 
        
      else
        puts "Sorry, that space is not available."
      end
    turn
    end
  end

  def turn
    if player1_turn
      player1_turn = false
    else
      player1_turn = true
    end
  end


  def victory
  end


end

class Cell
end


puts Game.new
