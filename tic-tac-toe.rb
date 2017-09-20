class Board

	@@horizontal_line = "-----"

	attr_accessor :top_row, :middle_row, :bottom_row, :spaces, :board

	def initialize
		@top_row = Row.new
		@middle_row = Row.new
		@bottom_row = Row.new
		@board = "#{@top_row.row}\n#{@@horizontal_line}\n#{@middle_row.row}\n#{@@horizontal_line}\n#{@top_row.row}"
		@spaces = {:top_left => self.top_row.left, :top_middle => self.top_row.middle, :top_right => self.top_row.right, 
			:middle_left => self.middle_row.left, :middle_middle => self.middle_row.middle, :middle_right => self.middle_row.right, 
			:bottom_left => self.bottom_row.left, :bottom_middle => self.bottom_row.middle, :bottom_right =>  self.bottom_row.right}
		puts @board
	end 

	def generate_board
		self.top_row.generate_row
		@board = "#{@top_row.row}\n#{@@horizontal_line}\n#{@middle_row.row}\n#{@@horizontal_line}\n#{@bottom_row.row}"
	end



	def place_x
		self.top_row.left = 'X'
		self.generate_board
		puts @board
	end


end

class Row

	attr_accessor :left, :middle, :right, :row

	@@vertical_line = "|"

	def initialize
		@left = " "
		@middle = " "
		@right = " "
		@row = "#{@left}#{@@vertical_line}#{@middle}#{@@vertical_line}#{@right}"
	end


	def generate_row
		@row = "#{@left}#{@@vertical_line}#{@middle}#{@@vertical_line}#{@right}"
	end

end

class Player

	@@total = 0
	attr_accessor :name

	def initialize
		if @@total < 1
			puts "What is Player One's name?"
			@name = gets.chomp
			@symbol = "X"
			puts "#{@name} is #{@symbol}"
		else
			puts "What is Player Two's name?"
			@name = gets.chomp
			@symbol = "O"
			puts "#{@name} is #{@symbol}"
		end
		@@total += 1 
	end
end

class TickTackToe

	attr_accessor :new_board

	def initialize
		@new_board = Board.new
		@player_one = Player.new
		@player_two = Player.new
	end



	def whos_turn
		turn = 1
		if turn % 2 != 0
			puts "It is #{@player_one.name}'s turn"
			turn += 1
			player_one_turn = true
		else
			puts "It is #{@player_one.name}'s turn"
			turn +=1
			player_one_turn = false
		end
	end

	def place_x_or_o
		turn = whos_turn
		if turn == true
			puts "Where would you like to put your X?"
			placement = gets.chomp.to_sym
			if blank_space?(placement)
				@new_board.spaces[placement]
				@new_board.generate_board
				puts @new_board.spaces[placement]
				puts @new_board.board
			end
		end
	end

	def blank_space?(target)
		empty = false
		if @new_board.spaces.include?(target)
			if @new_board.spaces[target] == ' '
				empty = true
			end
		end
		empty			
	end

	def left_middle_right(key)
		if @new_board.spaces[key] == :top_left || :middle_left || :bottom_left
			position = 'left'
		end
	end


end


new_game = TickTackToe.new
new_game.place_x_or_o
