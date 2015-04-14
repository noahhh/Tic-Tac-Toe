require 'pry'
class TicTacToe

attr_accessor :grid, :turns, :player1, :player2
Player = Struct.new(:mark)

  def initialize
	@grid = (1..9).to_a
  @turns = 0
	@player1 = Player.new("X")
	@player2 = Player.new("O")
  end

  def play_game
    loop do
      start_game
    end
    puts "Thanks for playing!"
  end

  def start_game
    until game_over?
      @turns += 1
      puts "\n #{turn?}, where would you like to place your mark?"
      display_board
      set_move(is_valid_pick?)
    end
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

  def win?

  end

  def turn?
    turns % 2 != 0 ? player1.mark : player2.mark
  end

  def player_pick
  	square = gets.chomp.match(/\d/)[0]
    return square.to_i - 1
  end

  def ai_pick
    square = @grid.sample.to_i - 1
  end


  def set_move(square)
    grid[square] = turn?
  end

  def is_valid_pick?
    loop do
      if turn? == "X"
  	    square = player_pick
      else
        square = ai_pick
      end
      if square_has_been_picked?(square) && turn? == "X"
        puts "That square has already been picked.  Please pick again."
        display_board
      elsif square_has_been_picked?(square) && turn? == "O"
        ai_pick
      else
        return square
      end
    end
  end

  def square_has_been_picked?(square)
    grid[square] == "X" || grid[square] == "O"
  end

  def game_over?
    false
  end

end

play = TicTacToe.new
play.play_game