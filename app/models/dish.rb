# frozen_string_literal: true

class Dish < ApplicationRecord
  has_and_belongs_to_many :ingredients

  validates :name, presence: true
  validates_uniqueness_of :name
end
