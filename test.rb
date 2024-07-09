class DefineMethod

	define_method :why do |args|
		puts "#{args} Ruby user"
	end
end
obj = DefineMethod.new
obj.why("hello")

# hello Ruby user



class MethodMissing
	def method_missing(method_name, *args)
		puts "Methode #{method_name} is missing with arguments #{args}"
	end
end

obj = MethodMissing.new
obj.i_am_the_missing_method(1,2,3,3,3)

# Methode i_am_the_missing_method is missing with arguments [1, 2, 3, 3, 3]

code = "puts 'Hello from puts '"
# puts code         # puts 'Hello from puts '
eval(code)        # Hello from puts
# p code            # "puts 'Hello from puts '"

inst_eval = "Hello i am instance eval"
obj.inst_eval {puts inst_eval}          # Methode inst_eval is missing with arguments []
obj.instance_eval {puts inst_eval}      # Hello i am instance eval


DefineMethod.class_eval do
	def this_is_class_eval_method
		puts "this is an example of class eval that how it can be used "
	end 
end

ev = DefineMethod.new
ev.this_is_class_eval_method   # this is an example of class eval that how it can be used 



1.send(:+, 2) # 3

p [1,2,4,9].to_s   # "[1,2,4,9]"

class Array
	def to_s
		'[]'
	end
end

p [1,2,4,9].to_s   #  "[]"




















# def speed_up(cars)
	# 	puts "Enter the service number of the car whom you want to increase the speed:"
	# 	service_number = gets.chomp
	# 	cars.each do |key, value|
	# 		if key == service_number
	# 			puts "Enter speed to increase:"
	# 			speed = gets.chomp.to_i
	# 			if speed <= 0 
	# 				puts "please provide speed value greater than 0"
	# 			else
	# 				value.speed += speed
	# 				puts "Speed updated. New speed: #{value.speed}"
	# 				break 
	# 			end 
	# 		else
	# 			puts "Car with service number '#{service_number}' not found."
	# 		end
	# 	end
	# end



	# def brake(cars)
	# 	puts "Enter the service number of the car whom you want to increase the speed:"
	# 	service_number = gets.chomp
	# 	cars.each do |key, value|
	# 		if key == service_number
	# 			puts "Enter speed to decrease:"
	# 			speed = gets.chomp.to_i
	# 			if speed > value.speed 
	# 				puts "you cannot decerase than #{value.speed}"
	# 			elsif speed <= 0 
	# 				puts "please provide speed value greater than 0"
	# 			else
	# 				value.speed -= speed
	# 				puts "Speed has been decreased to: #{value.speed}"
	# 				break  
	# 			end
	# 		else
	# 			puts "please provide valid service number"
	# 		end
	# 	end
	# end

	# def shut_down(cars)
	# 	puts "Enter the service number of the car whom you want to increase the speed:"
	# 	service_number = gets.chomp
	# 	cars.each do |key, value|
	# 		if key == service_number
	# 			value.speed = 0
	# 			puts "Car has been shut down"
	# 			break  
	# 		else
	# 			puts "please provide valid service number"
	# 		end
	# 	end
	# end

	# def spray_paint(cars)
	# 	puts "Enter the service number of the car whom you want to increase the speed:"
	# 	service_number = gets.chomp
	# 	cars.each do |key, value|
	# 		if key == service_number
	# 			loop do
	# 				puts "Enter new_color:"
	# 				new_color = gets.chomp
	# 				if VALID_COLOR.include?(new_color)
	# 					value.color = new_color
	# 					puts "Car color has been changed to: #{value.color}"
	# 					break
	# 				else
	# 					puts "Please select car color from #{VALID_COLOR}"
	# 				end
	# 			end
	# 		else
	# 			puts "please provide valid service number"
	# 		end
	# 	end
	# end