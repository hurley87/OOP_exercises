class Plateau 
	attr_accessor :width, :height
	def initialize(width, height)
		@width = width
		@height =  height
	end
end

class Rover
	attr_accessor :x, :y, :orientation, :plateau
	def initialize(x, y, orientation, plateau)
		@x = x
		@y = y
		@orientation = orientation
		@plateau = plateau
	end
	def instruction(str)
		width = plateau.width
		height = plateau.height
		str.each_char do |char|
			if char == "M"
				move
			else
				rotate(char) 
			end
		end
		if (0..width).include?(@x) && (0..height).include?(@y)
			puts "#{@x} #{@y} #{@orientation}" 
		else
			puts "your the worst driver ever"
		end
	end
	def move
		case orientation
			when "N" then @y += 1
			when "S" then @y -= 1
			when "E" then @x += 1
			when "W" then @x -= 1
		end
	end
	def rotate(hand)
		arr = ["W", "S", "E", "N"]	  
		arr.reverse! if hand == "R"
		@orientation = arr[arr.index(@orientation) - 1] 
	end	
end

input = gets.chomp.split(" ")
mars = Plateau.new(input[0].to_i, input[1].to_i)
i2 = gets.chomp.split(" ")
new_rover = Rover.new(i2[0].to_i, i2[1].to_i, i2[2], mars)
direction = gets.chomp
new_rover.instruction(direction)


