# frozen_string_literal: true

class DishesController < ApplicationController
  def create
    tempfile = params.dig(:dishes, :yml)&.tempfile
    dishes = YAML.safe_load_file(tempfile) if File.extname(tempfile) == '.yml'

    if dishes
      flash[:settings_notice] = 'menu loaded from file'
      ImportDishesWorker.perform_async(dishes)
    end

    redirect_to new_dishes_path
  end
end
