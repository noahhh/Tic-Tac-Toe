class TicTacToe

attr_accessor :board, :turns, :player1, :player2
Player = Struct.new(:mark)

  def initialize
	@board = (1..9).to_a
  @turns = 0
	@player1 = Player.new("X")
	@player2 = Player.new("O")
  end

  def start_game
    until game_over?
      @turns += 1
      if turn? == "X"
        puts "\n #{turn?}, enter the number where you would like to place your mark."
      elsif turn? == "O"
        puts "\n #{turn?} places his mark."
      end
      display_board
      set_move(is_valid_pick?)
    end
    game_message
    display_board
    play_again?
  end

  def display_board
		board.each_with_index do |square, index|
			if (index+1) % 3 == 0
				print " #{square} \n"
				print "-----------\n" if index != 8 # no line on the bottom of the board
			else
				print " #{square} |"
			end
		end
	end

  def win_conditions
    row1 = board.each_index.select { |i| (i+1) <= 3 }
    row2 = board.each_index.select { |i| (i+1) > 3 && (i+1) < 7 }
    row3 = board.each_index.select { |i| (i+1) >= 7 }
    col1 = board.each_index.select { |i| (i+1) == 1 || (i+1) == 4 || (i+1) == 7 }
    col2 = board.each_index.select { |i| (i+1) == 2 || (i+1) == 5 || (i+1) == 8 }
    col3 = board.each_index.select { |i| (i+1) == 3 || (i+1) == 6 || (i+1) == 9 }
    diagonal1 = board.each_index.select { |i| (i+1) == 1 || (i+1) == 5 || (i+1) == 9 }
    diagonal2 = board.each_index.select { |i| (i+1) == 3 || (i+1) == 5 || (i+1) == 7 }
    @win_conditions = [row1,row2,row3,col1,col2,col3,diagonal1,diagonal2]
  end

  def win?
    win_conditions.any? { |condition| condition.all? { |i| board[i] == "X" } || condition.all? { |i| board[i] == "O" } }
  end

  def tie?
    win_conditions.all? { |condition| condition.all? { |i| board[i] == "X" || board[i] == "O" } }
  end

  def turn?
    turns % 2 != 0 ? player1.mark : player2.mark
  end

  def player_pick
  	square = gets.chomp.match(/\d/)[0] # [0] or otherwise would return #<MatchData "1">/couldn't turn in to integer
    return square.to_i - 1 # -1 to account for index [0]
  end

  def ai_pick
    square = @board.sample.to_i - 1
  end

  def set_move(square)
    board[square] = turn?
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
    board[square] == "X" || board[square] == "O"
  end

  def game_over?
    win? || tie?
  end

  def play_again?
    puts "\n Play again? (Y/N):"
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

  def reset_board
    @board = (1..9).to_a
  end

  def reset_turns
    @turns = 0
  end

  def game_message
    puts "\n Player #{turn?} wins!" if win?
    puts "\n The game ends in a tie!" if tie? && !win?
  end

end

play = TicTacToe.new
play.start_game