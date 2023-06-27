# frozen_string_literal: true

class ImportDishesWorker
  include Sidekiq::Job

  def perform(menu)
    menu['ingredients'].each do |ingredient|
      Ingredient.create name: ingredient
    end

    menu['dishes'].each do |dish|
      new_dish = Dish.find_or_create_by name: dish['name']

      dish['ingredients'].each do |ingredient_name|
        begin
          ingredient = Ingredient.create! name: ingredient_name
          new_dish.ingredients << ingredient unless new_dish.ingredients.include? ingredient
        rescue ActiveRecord::RecordInvalid
          next
        end
      end
    end
  end
end
