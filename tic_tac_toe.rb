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

  # def play_game
  #   loop do
  #     start_game
  #     # break unless play_again?
  #   end
  #   puts "Thanks for playing!"
  # end

  def start_game
    until game_over?
      @turns += 1
      puts "\n #{turn?}, where would you like to place your mark?"
      display_board
      set_move(is_valid_pick?)
    end
    display_board
    play_again?
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

  def win_conditions
    row1 = grid.each_index.select { |i| (i+1) <= 3 }
    @win_conditions = [row1]
  end

  def win?
    win_conditions.any? { |condition| condition.all? { |i| grid[i] == "X" } || condition.all? { |i| grid[i] == "O" } }
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
    win?
  end

  def reset_board
    @grid = (1..9).to_a
  end

  def reset_turns
    @turns = 0
  end

  def play_again?
    puts "\nPlay again? (Y/N):"
    answer = gets.chomp.downcase
    if answer == "y"
      reset_board
      reset_turns
      start_game
    elsif answer == "n"
      puts "Goodbye"
      exit
    else
      puts "Please answer with (Y/N)"
      play_again?
    end
  end

end

play = TicTacToe.new
play.start_game