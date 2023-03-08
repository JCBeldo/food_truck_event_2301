require 'spec_helper'

RSpec.describe Event do
  describe '#initialize' do
    it 'exists and has attributes' do
      event = Event.new('South Pearl Street Farmers Market')

      expect(event.name).to eq('South Pearl Street Farmers Market')
      expect(event.food_trucks).to eq([])
    end
  end

  describe '#add_food_truck' do
    it 'adds foodtrucks to the event' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
    end
  end

  describe '#food_truck_names' do
    it 'returns a list of food-truck names found at the event' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)

      expect(event.food_truck_names).to eq(['Rocky Mountain Pies', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
    end
  end
end
