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
		self.middle_row.generate_row
		self.bottom_row.generate_row
		@board = "#{@top_row.row}\n#{@@horizontal_line}\n#{@middle_row.row}\n#{@@horizontal_line}\n#{@bottom_row.row}"
		puts @spaces = {:top_left => self.top_row.left, :top_middle => self.top_row.middle, :top_right => self.top_row.right, 
			:middle_left => self.middle_row.left, :middle_middle => self.middle_row.middle, :middle_right => self.middle_row.right, 
			:bottom_left => self.bottom_row.left, :bottom_middle => self.bottom_row.middle, :bottom_right =>  self.bottom_row.right}
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
		@turn = 1
	end



	def whos_turn?
		if @turn % 2 != 0
			puts "It is #{@player_one.name}'s turn"
			@turn += 1
			player_one_turn = true
		else
			puts "It is #{@player_one.name}'s turn"
			@turn +=1
			player_one_turn = false
		end
	end

	def place_x_or_o
		while self.game_over? == false
			if self.whos_turn?
				puts "Where would you like to put your X?"
				placement = gets.chomp.to_sym
				if blank_space?(placement)
					self.change_space_to_x(placement.to_s)
					#self.check_left_right_middle(placement.to_s)
					self.new_board.generate_board
					puts @new_board.board
				end
			else 
				puts "Where would you like to put your O?"
				placement = gets.chomp.to_sym
				if blank_space?(placement)
					self.change_space_to_o(placement.to_s)
					#self.check_left_right_middle(placement.to_s)
					self.new_board.generate_board
					puts @new_board.board
				end
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

	def check_top_middle_bottom(row)
		if row.include?('top')
			self.new_board.top_row
		end
	end

	def check_left_right_middle(column)
		if column.include?('left')
			self.check_top_middle_bottom(column).left
		end
	end


	def change_space_to_x(input)
		if input.include?('top_left')
			self.new_board.top_row.left = 'X'
		end
		if input.include?('top_middle')
			self.new_board.top_row.middle = 'X'
		end
		if input.include?('top_right')
			self.new_board.top_row.right = 'X'
		end
		if input.include?('middle_left')
			self.new_board.middle_row.left = 'X'
		end
		if input.include?('middle_middle')
			self.new_board.middle_row.middle = 'X'
		end
		if input.include?('middle_right')
			self.new_board.middle_row.right = 'X'
		end
		if input.include?('bottom_left')
			self.new_board.bottom_row.left = 'X'
		end
		if input.include?('bottom_middle')
			self.new_board.bottom_row.middle = 'X'
		end
		if input.include?('bottom_right')
			self.new_board.bottom_row.right = 'X'
		end		
	end

	def change_space_to_o(input)
		if input.include?('top_left')
			self.new_board.top_row.left = 'O'
		end
		if input.include?('top_middle')
			self.new_board.top_row.middle = 'O'
		end
		if input.include?('top_right')
			self.new_board.top_row.right = 'O'
		end
		if input.include?('middle_left')
			self.new_board.middle_row.left = 'O'
		end
		if input.include?('middle_middle')
			self.new_board.middle_row.middle = 'O'
		end
		if input.include?('middle_right')
			self.new_board.middle_row.right = 'O'
		end
		if input.include?('bottom_left')
			self.new_board.bottom_row.left = 'O'
		end
		if input.include?('bottom_middle')
			self.new_board.bottom_row.middle = 'O'
		end
		if input.include?('bottom_right')
			self.new_board.bottom_row.right = 'O'
		end		
	end

	def game_over?
		if self.x_winner?
			true
			puts '#{@player_one} wins the game!'
		elsif self.o_winner?
			true
			puts '#{@player_two} wins the game!'
		elsif self.draw?
			true
			puts "The game ends in a draw!"
		else
			false
		end
	end

	def x_winner?
		if self.new_board.spaces[:top_left] == "X" && self.new_board.spaces[:top_middle] == "X" && self.new_board.spaces[:top_right] == "X"
			true
		elsif self.new_board.spaces[:middle_left] == "X" && self.new_board.spaces[:middle_middle] == "X" && self.new_board.spaces[:middle_right] == "X"
			true
		elsif self.new_board.spaces[:bottom_left] == "X" && self.new_board.spaces[:bottom_middle] == "X" && self.new_board.spaces[:bottom_right] == "X"
			true
		elsif self.new_board.spaces[:top_left] == "X" && self.new_board.spaces[:middle_middle] == "X" && self.new_board.spaces[:bottom_right] == "X"
			true
		elsif self.new_board.spaces[:bottom_left] == "X" && self.new_board.spaces[:middle_middle] == "X" && self.new_board.spaces[:top_right] == "X"
			true
		elsif self.new_board.spaces[:top_left] == "X" && self.new_board.spaces[:middle_left] == "X" && self.new_board.spaces[:bottom_left] == "X"
			true
		elsif self.new_board.spaces[:top_middle] == "X" && self.new_board.spaces[:middle_middle] == "X" && self.new_board.spaces[:bottom_middle] == "X"
			true
		elsif self.new_board.spaces[:top_right] == "X" && self.new_board.spaces[:middle_right] == "X" && self.new_board.spaces[:bottom_right] == "X"
			true
		else
			false
		end			
	end

	def o_winner?
		if self.new_board.spaces[:top_left] == "O" && self.new_board.spaces[:top_middle] == "O" && self.new_board.spaces[:top_right] == "O"
			true
		elsif self.new_board.spaces[:middle_left] == "O" && self.new_board.spaces[:middle_middle] == "O" && self.new_board.spaces[:middle_right] == "O"
			true
		elsif self.new_board.spaces[:bottom_left] == "O" && self.new_board.spaces[:bottom_middle] == "O" && self.new_board.spaces[:bottom_right] == "O"
			true
		elsif self.new_board.spaces[:top_left] == "O" && self.new_board.spaces[:middle_middle] == "O" && self.new_board.spaces[:bottom_right] == "O"
			true
		elsif self.new_board.spaces[:bottom_left] == "O" && self.new_board.spaces[:middle_middle] == "O" && self.new_board.spaces[:top_right] == "O"
			true
		elsif self.new_board.spaces[:top_left] == "O" && self.new_board.spaces[:middle_left] == "O" && self.new_board.spaces[:bottom_left] == "O"
			true
		elsif self.new_board.spaces[:top_middle] == "O" && self.new_board.spaces[:middle_middle] == "O" && self.new_board.spaces[:bottom_middle] == "O"
			true
		elsif self.new_board.spaces[:top_right] == "O" && self.new_board.spaces[:middle_right] == "O" && self.new_board.spaces[:bottom_right] == "O"
			true
		else
			false
		end			
	end

	def draw?
		if @turn > 9
			true
		else
			false
		end
	end




end


new_game = TickTackToe.new
new_game.place_x_or_o
