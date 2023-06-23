# frozen_string_literal: true

class Order < ApplicationRecord
  has_and_belongs_to_many :ingredients, join_table: :excluded_ingredients
end
