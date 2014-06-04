class Person
	attr_accessor :name
	def initialize(name)
		@name = name
	end
	def greeting
		"Hi, my name is #{@name}"
	end
end

class Student < Person
	def learn
		"I get it!"
	end
end
class Instructor < Person
	def teach
		"Everything in Ruby is an Object"
	end
end

chris = Instructor.new("Chris")
christina = Student.new("Christina")
puts christina.greeting
puts chris.greeting

puts chris.learn
#we get a noMethodError when we try to use a method that's defined in that class or parent clas