class Order
	def initialize
		@total = 0
		@sales_tax = 0
		@item_cost = 0
		@to_return = {}
		@@order_num += 1
	end

	def add(str)
		str[/(.+) at (.+)/]
		item = $1
		cost = $2.to_f
		if item =~ /imported/
			@to_return[item] = import_tax(cost)
		elsif item =~ /book|chocolate|pills/
			@total += cost
			@to_return[item] = cost
		else
			@to_return[item] = sales_tax(cost)
		end
	end

	def sales_tax(cost)
		@item_cost = cost * 1.1
		@sales_tax += cost * 0.1
		@total += @item_cost
		@item_cost
	end

	def import_tax(cost)
		@item_cost = cost * 1.05
		@sales_tax += cost * 0.05
		@total += @item_cost
		@item_cost
	end

	def output 
		puts "Here is your order:"
		@to_return.each do |key,value|
			puts "#{key}: #{value}"
		end 
		puts "Sales Taxes: #{@sales_tax}"
		puts "Total: #{@total}"
		puts ""
	end
end

def greeting
	puts "Please add items (type \"done\" when finished)"
	order1 = Order.new
	order(order1)
end

def order(order1)
	response = gets.chomp
	unless response == "done"
		order1.add(response)
		order(order1)
	end
	order1.output
end

greeting