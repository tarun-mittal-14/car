	$LOAD_PATH << '.'
	require 'car.rb'
	require 'byebug'

	class Menu
		def open_main_menu(cars)
			puts "Enter your choice"
			puts "1 Create Car"
			puts "2 view cars"
			puts "3 increase speed of car"
			puts "4 decrease speed of car"
			puts "5 Turn off car"
			puts "6 Change color of the car"
			puts "7 Exit " 
			puts
			choice = gets.chomp.to_i
			case choice
			when 1
				new_car = Car.new.create_car
				cars[new_car.service_number] = new_car
				open_main_menu(cars)
			when 2
				view_car = Car.new.get_car(cars)
				open_main_menu(cars)
			when 3
				increase = Car.new.speed_up(cars)
				open_main_menu(cars)
			when 4
				decrease = Car.new.brake(cars)
				open_main_menu(cars)
			when 5
				off = Car.new.shut_down(cars)
				open_main_menu(cars)
			when 6
				change_color = Car.new.spray_paint(cars)
				open_main_menu(cars)
			when 7
				puts "Exiting....."
				exit
			else 
				puts "Please Enter valid choice"
				open_main_menu(cars)
			end
		end
	end


