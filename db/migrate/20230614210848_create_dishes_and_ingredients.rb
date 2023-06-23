# frozen_string_literal: true

class CreateDishesAndIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :dishes, :name, unique: true

    create_table :dishes_ingredients, id: false do |t|
      t.belongs_to :dish
      t.belongs_to :ingredient
    end
  end
end
