class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    food_trucks.push(food_truck)
  end

  def food_truck_names
    food_trucks.map(&:name)
  end

  def food_trucks_that_sell(item)
    food_trucks.select { |food_truck| food_truck.inventory.key?(item) }
  end

  def all_items
    food_trucks.flat_map do |food_truck|
      food_truck.inventory.keys
    end.uniq
  end
end
