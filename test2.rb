require 'securerandom'
require 'thread'
class Station
  attr_reader :name
  def initialize(name)
    @name = name
  end
end
class Route
  attr_reader :start_station, :end_station, :name
  def initialize(start_station, end_station, name)
    @start_station = start_station
    @end_station = end_station
    @name = name
  end
  def self.create_routes
    indore = Station.new("Indore")
    dewas = Station.new("Dewas")
    ujjain = Station.new("Ujjain")
    bhopal = Station.new("Bhopal")
    [
      new(indore, ujjain, "indore_to_ujjain"),
      new(indore, ujjain, "indore_to_ujjain_via_dewas"),
      new(indore, dewas, "indore_to_dewas"),
      new(indore, dewas, "indore_to_dewas_via_ujjain"),
      new(indore, bhopal, "indore_to_bhopal"),
      new(indore, bhopal, "indore_to_bhopal_via_dewas"),
      new(indore, bhopal, "indore_to_bhopal_via_ujjain")
    ]
  end
  def self.routes_by_destination(destination)
    case destination.downcase
    when "dewas"
      create_routes.select { |route| route.end_station.name.downcase == "dewas" }
    when "ujjain"
      create_routes.select { |route| route.end_station.name.downcase == "ujjain" }
    when "bhopal"
      create_routes.select { |route| route.end_station.name.downcase == "bhopal" }
    else
      []
    end
  end
end
class Train
  DESTINATIONS = ["dewas", "ujjain", "bhopal"]
  ROUTES_IN_USE = []
  attr_reader :train_no, :name, :current_route, :destination
  def initialize(train_no, name, destination)
    @train_no = train_no
    @name = name
    @destination = destination
    @current_route = nil
  end
  def self.create_train
    train_no = SecureRandom.uuid
    puts "Enter name of train: "
    name = gets.chomp
    destination = nil
    loop do
      puts "Enter destination of train: "
      destination = gets.chomp.downcase
      break if DESTINATIONS.include?(destination)
      puts "Please select destination from #{DESTINATIONS.map(&:capitalize)}"
    end
    route = validate_route(destination)
    new_train = Train.new(train_no, name, destination)
    new_train.assign_route(route) if route
    new_train
  end
  def self.get_trains(trains)
    trains.each_value do |train|
      puts "TRAIN_NUMBER: #{train.train_no} \nNAME: #{train.name} \nFROM: Indore \nTO: #{train.destination.capitalize} \nCURRENT_ROUTE: #{train.current_route&.name}"
      puts
    end
  end
  def self.validate_route(destination)
    available_routes = Route.routes_by_destination(destination)
    select_route(available_routes)
  end
  def self.select_route(route_array)
    loop do
      route_array.each { |route| puts route.name }
      puts "\nSelect the route to reach the destination (enter 'q' to quit):"
      input = gets.chomp
      if input == 'q'
        return nil
      elsif route_array.map(&:name).include?(input)
        if ROUTES_IN_USE.include?(input)
          puts "#{input} is already in use. Please select another route."
        else
          ROUTES_IN_USE << input
          puts "#{input} has been added to ROUTES_IN_USE."
          return route_array.find { |route| route.name == input }
        end
      else
        puts "Invalid input. Please select a route from the list."
      end
    end
  end
  def assign_route(route)
    @current_route = route
  end
  def start_moving
    if @current_route
      puts "Train #{@name} is moving on route #{@current_route.name} towards #{@destination.capitalize}."
      sleep(30)
      puts "Train #{@name} has reached #{@destination.capitalize}."
      self.class.unlock_route(@current_route.name)
      @current_route = nil
    else
      puts "Train #{@name} has no route assigned."
    end
  end
  def self.unlock_route(route_name)
    ROUTES_IN_USE.delete(route_name)
    puts "Route #{route_name} is now available for other trains."
  end
end
class Menu
  def open_main_menu(trains, train_threads)
    puts "Enter your choice"
    puts "1 Create train"
    puts "2 View trains"
    puts "3 Move train"
    puts "4 Exit"
    puts
    choice = gets.chomp.to_i
    case choice
    when 1
      new_train = Train.create_train
      trains[new_train.train_no] = new_train if new_train
      open_main_menu(trains, train_threads)
    when 2
      Train.get_trains(trains)
      open_main_menu(trains, train_threads)
    when 3
      move_train(trains, train_threads)
      open_main_menu(trains, train_threads)
    when 4
      puts "Exiting....."
      train_threads.each(&:join)
      exit
    else
      puts "Please enter a valid choice"
      open_main_menu(trains, train_threads)
    end
  end
  def move_train(trains, train_threads)
    puts "Enter train number to move: "
    train_no = gets.chomp
    train = trains[train_no]
    if train
      train_thread = Thread.new { train.start_moving }
      train_threads << train_thread
    else
      puts "Train not found."
    end
  end
end
class Main
  def main_method
    trains = {}
    train_threads = []
    menu = Menu.new
    menu.open_main_menu(trains, train_threads)
  end
end
main = Main.new
main.main_method
