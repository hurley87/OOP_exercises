class Receipt
	attr_accessor :items, :total_tax, :total_price
	
	def initialize(items = [])
		@items = items
		@total_tax = 0
		@total_price = 0
	end
	def find_quantity(str)
		str[0].to_i
	end
	def find_price(str)
		price = str.scan(/\d+[.]\d+/)
		price[0].to_f
	end
	def imported?(str)
		str.split(' ').include?("imported")
	end
	def exempt?(str)
		exempt_words = ["book", "pills", "chocolate"]
		exempt_words.each do |word|
			return true if str.split(' ').include?(word)
		end
		false
	end	
	def to_s
		items.each do |item|
			quantity = find_quantity(item)
			price = find_price(item)
			is_imported = imported?(item)
			is_exempt = exempt?(item)
			new_item = Item.new(quantity, price, is_imported, is_exempt)
			p item.scan(/(.+) at (.+)/)[0][0] + ": " + "#{new_item.final_cost}"
			@total_tax += new_item.compute_tax/2.round(2)
			@total_price += new_item.final_cost
		end
			p "Sales Taxes: #{@total_tax}"
		 p "Total: #{(@total_price - @total_tax*2).round(2)}"
	end
end

class Item 
	attr_accessor :quantity, :price, :imported, :exempt
	def initialize(q, p, is_imported, is_exempt)
		@quantity = q
		@price = p
		@percent_tax = 0
		@imported = is_imported
		@exempt = is_exempt
	end
	def find_tax
		@percent_tax += 5 if imported 
		@percent_tax += 10 if !exempt 
	end
	def final_cost
		find_tax
		final = price + price*(@percent_tax.to_f/100)
		final.round(2)
	end
	def compute_tax
	  find_tax
	  raw_value = (quantity * price * (@percent_tax/100.0))
	  rounded_value = (raw_value * 20).ceil / 20.0
	  rounded_value
	end
end

# first = "1 imported box of chocolates at 10.00"
# second = "1 imported bottle of perfume at 47.50"

# first = "1 book at 12.49"
# second = "1 music CD at 14.99"
# third = "1 chocolate bar at 0.85"

first = "1 imported bottle of perfume at 27.99"
second = "1 bottle of perfume at 18.99"
third = "1 packet of headache pills at 9.75"
fourth = "1 box of imported chocolates at 11.25"

new_order = Receipt.new([first, second, third, fourth])
new_order.to_s



