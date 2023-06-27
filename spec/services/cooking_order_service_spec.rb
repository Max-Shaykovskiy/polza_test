require "rails_helper"

RSpec.describe CookingOrderService, type: :service do
  it 'returns the correct total cooking order' do
    ingredient1 = Ingredient.create name: 'ingredient1'
    ingredient2 = Ingredient.create name: 'ingredient2'
    dish1 = Dish.create name: 'dish1'
    dish2 = Dish.create name: 'dish2'
    dish1.ingredients << ingredient1
    dish2.ingredients << ingredient2
    order1 = Order.create
    order2 = Order.create
    order1.ingredients << ingredient1

    cooking_order = described_class.new(Order.all, Dish.all).call

    expect(cooking_order)
      .to match([
        a_hash_including({:name=>"dish2", :count=>2}),
        a_hash_including({:name=>"dish1", :count=>1})
      ])

    expect(cooking_order[0][:count]).to be > cooking_order[1][:count]
  end
end
