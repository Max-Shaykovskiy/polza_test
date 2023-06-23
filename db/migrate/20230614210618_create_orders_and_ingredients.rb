# frozen_string_literal: true

class CreateOrdersAndIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, &:timestamps

    create_table :excluded_ingredients, id: false do |t|
      t.belongs_to :order
      t.belongs_to :ingredient
    end
  end
end
