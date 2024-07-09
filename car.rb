$LOAD_PATH << '.'
require 'menu.rb'
require 'securerandom'
require "byebug"
class Car

	VALID_COLOR = ['white', 'black', 'red', 'blue', 'silver']

	attr_accessor :color, :speed, :model, :service_number
	attr_reader :year

	def initialize(model = nil, color = nil , year = nil, speed = 0 ,service_number = nil)
		@model = model
		@color = color
		@year = year
		@speed = speed 
		@service_number = service_number
	end	

	def create_car
		service_number = SecureRandom.uuid
		puts "enter model of car: "
		model = gets.chomp
		color = nil
		loop do
			puts "Enter color of car: "
			color = gets.chomp
			break if VALID_COLOR.include?(color)
			puts "Please select car color from #{VALID_COLOR}"
		end
		year = nil
		loop do
			puts "Enter year of car (four digits): "
			year = gets.chomp
			break if year =~ /^\d{4}$/ 
			puts "Invalid year format. Please enter a four-digit year."
		end
		speed = nil
		loop do
			puts "Enter speed of car: "
			speed = gets.chomp.to_i
			break if speed >= 1 
			puts "Speed should be greater than 0"
		end
		new_car = Car.new(model, color, year, speed, service_number)
		new_car
	end


	def get_car(cars)
		cars.each_value do |car|
			puts "MODEL : #{car.model} \n COLOR : #{car.color} \n YEAR : #{car.year} \n SPEED : #{car.speed} \n SERVICE  : #{car.service_number} "
			puts 
		end
	end

	def speed_up(cars)
		puts "Enter the service number of the car to increase speed:"
		service_number = gets.chomp
		if cars[service_number]
			car = cars[service_number]
			puts "Enter speed to increase:"
			speed = gets.chomp.to_i
			check_speed(speed) ? (car.speed += speed; puts "Speed updated. New speed: #{car.speed}") : (puts "Please provide a speed value greater than 0.")
		else
			puts "Car with service number '#{service_number}' not found."
		end
	end

	def brake(cars)
		puts "Enter the service number of the car to decrease speed:"
		service_number = gets.chomp
		if cars[service_number]
			car = cars[service_number]
			puts "Enter speed to decrease:"
			speed = gets.chomp.to_i
			check_speed(speed) ? (speed > car.speed ? puts("Cannot decrease speed beyond #{car.speed}.") : (car.speed -= speed; puts("Speed decreased to: #{car.speed}"))) :
			puts("Please provide a speed value greater than 0.")
		else
			puts "Car with service number '#{service_number}' not found."
		end
	end

	def shut_down(cars)
		puts "Enter the service number of the car to shut down:"
		service_number = gets.chomp
		if car = cars[service_number]
			car.speed = 0
			puts "Car has been shut down"
		else
			puts "Car with service number '#{service_number}' not found."
		end
	end


	def spray_paint(cars)
		puts "Enter the service number of the car to spray paint:"
		service_number = gets.chomp
		byebug
		if car = cars[service_number]
			loop do
				puts "Enter new color:"
				new_color = gets.chomp
				if VALID_COLOR.include?(new_color)
					car.color = new_color
					puts "Car color has been changed to: #{car.color}"
					break
				else
					puts "Please select a valid color from #{VALID_COLOR}."
				end
			end
		else
			puts "Car with service number '#{service_number}' not found."
		end
	end

	def check_speed(speed)
		speed > 0
	end
end



