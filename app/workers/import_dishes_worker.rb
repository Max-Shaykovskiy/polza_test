# frozen_string_literal: true

class ImportDishesWorker
  include Sidekiq::Job

  def perform(dishes)
    dishes['ingredients'].each do |ingredient|
      Ingredient.find_or_create_by name: ingredient
    end

    dishes['dishes'].each do |dish|
      new_dish = Dish.find_or_create_by name: dish['name']

      dish['ingredients'].each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by name: ingredient_name
        new_dish.ingredients << ingredient unless new_dish.ingredients.include? ingredient
      end
    end
  end
end
