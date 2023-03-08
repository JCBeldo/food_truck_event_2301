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

  def total_quantity(item)
    food_trucks.flat_map do |food_truck|
      food_truck.inventory[item]
    end.sum
  end

  def sorted_item_list
    names_of_items = []
    food_trucks.each do |food_truck|
      food_truck.inventory.each do |ft_item, quantity|
        names_of_items.push(ft_item.name)
      end
    end
    names_of_items.sort.uniq
  end

  def overstocked_items
    all_items.select do |item|
      total_quantity(item) > 50 && food_trucks_that_sell(item).count > 1
    end
  end

  def total_inventory
    all_inventory = {}
    food_trucks.flat_map do |food_truck|
      food_truck.inventory.map do |ft_item, quantity|
        if !all_inventory.has_key?(ft_item)
          ft_trucks = Hash.new
          ft_trucks[:quantity] = 0
          ft_trucks[:food_trucks] = []
          all_inventory[ft_item] = ft_trucks
          ft_trucks[:quantity] = total_quantity(ft_item)
          ft_trucks[:food_trucks] = all_items
        else
          all_inventory[ft_item] = total_quantity(ft_item)
          all_inventory[ft_item] = all_items
        end
      end
    end.uniq
  end
end
