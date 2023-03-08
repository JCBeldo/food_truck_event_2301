require 'spec_helper'

RSpec.describe Event do
  describe '#initialize' do
    it 'exists and has attributes' do
      event = Event.new("South Pearl Street Farmers Market")
      
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])
    end
  end
end