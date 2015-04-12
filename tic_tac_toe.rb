class TicTacToe

attr_accessor :grid, :player1, :player2
Player = Struct.new(:mark)

  def initialize
	@grid = (1..9).to_a
	@player1 = Player.new("X")
	@player2 = Player.new("O")
  end

  def play_game
    start_game
    until game_over?
      puts "pick a square"
      display_board
      set_move(is_valid_pick?)
    end
  end

  def start_game
    puts "\n Where would you like to place your mark?"
    display_board
    player_pick
  end

  def display_board
		grid.each_with_index do |square, index|
			if (index+1) % 3 == 0
				print " #{square} \n"
				print "-----------\n" if index != 8 # no line on the bottom of the board
			else
				print " #{square} |"
			end
		end
	end

  def player_pick
  	square = gets.chomp.match(/\d/)[0]
  end

  def set_move(square)
    grid[square] = player_pick
  end

  def is_valid_pick?
  	square = player_pick
    if square_has_been_picked?(square)
      puts "no"
    else
      return square
    end
  end

  def square_has_been_picked?(square)
    grid[square] == "X" || grid[square] == "O"
  end

  def game_over?
  end

end

play = TicTacToe.new
play.play_game