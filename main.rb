$LOAD_PATH << '.'
require 'menu.rb'
require 'car.rb'


class Main
	def main_method
		cars = Hash.new
		menu = Menu.new
		menu.open_main_menu(cars)
	end
end

main = Main.new
main.main_method