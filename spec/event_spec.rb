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
 
  describe '#food_trucks_that_sell' do
    it 'lists food trucks that sell certain items' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck3.stock(item1, 65)
      food_truck2.stock(item4, 50)
      food_truck2.stock(item3, 25)
      
      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end
  end
  
  describe '#all_items' do
    it 'lists all items held by the food trucks' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck3.stock(item1, 65)
      food_truck2.stock(item3, 25)
      food_truck2.stock(item4, 50)

      expect(event.all_items).to eq([item1, item2, item3, item4])
    end
  end

  describe '#overstocked_items' do
    it 'returns a list of items that are held by more than one food_truck with a quantity over 50' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck3.stock(item1, 65)
      food_truck2.stock(item3, 25)
      food_truck2.stock(item4, 50)
      
      expect(event.overstocked_items).to eq([item1])
    end
  end
  
  describe '#sorted_item_list' do
    it 'returns a list of all items' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck3.stock(item1, 65)
      food_truck2.stock(item3, 25)
      food_truck2.stock(item4, 50)

      expect(event.sorted_item_list).to eq('Apple Pie (Slice)', 'Banana Nice Cream', 'Peach-Raspberry Nice Cream','Peach Pie (Slice)')
    end
  end

  describe '#total_inventory' do
    xit 'returns a hash of total inventory from an event' do
      event = Event.new('South Pearl Street Farmers Market')
      food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      food_truck3 = FoodTruck.new('Palisade Peach Shack')
      event.add_food_truck(food_truck1)
      event.add_food_truck(food_truck2)
      event.add_food_truck(food_truck3)
      item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck3.stock(item1, 65)
      food_truck2.stock(item3, 25)
      food_truck2.stock(item4, 50)

      expected = {
        item1 => {
          quantity: 100,
          food_trucks: [food_truck1, food_truck3]
        },
        item2 => {
          quantity: 7,
          food_trucks: [food_truck1]
        },
        item3 => {
          quantity: 25,
          food_trucks: [food_truck2]
        },
        item4 => {
          quantity: 50,
          food_trucks: [food_truck2]
        }
      }

      expect(event.total_quantity(item1)).to eq(100)
      expect(event.total_inventory).to eq(expected)
    end
  end
end
