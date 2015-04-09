class TicTacToe

attr_accessor :grid

  def initialize
	@grid = (1..9).to_a
  end

  def display_board
		grid.each_with_index do |square, index|
			if (index+1) % 3 == 0
				print " #{square} \n"
				print "-----------\n" if index != 8
			else
				print " #{square} |"
			end
		end
	end

end

x = TicTacToe.new
x.display_board