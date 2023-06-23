# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_and_belongs_to_many :orders, join_table: :excluded_ingredients
  has_and_belongs_to_many :dishes

  validates :name, presence: true
  validates_uniqueness_of :name
end
