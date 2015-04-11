class TicTacToe

attr_accessor :grid, :player1, :player2
Player = Struct.new(:mark)

  def initialize
	@grid = (1..9).to_a
	@player1 = Player.new("X")
	@player2 = Player.new("O")
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

  def start_game
  	puts "\n Where would you like to place your mark?"
  	display_board
  	player_pick
  end

  # def player_pick
  # 	square = gets.chomp.match(/\d/)[0]
  # end

  # def valid_pick?
  # 	square = player_pick
  # end


end

play = TicTacToe.new
play.start_game