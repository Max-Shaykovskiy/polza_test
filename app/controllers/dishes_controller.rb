# frozen_string_literal: true

class DishesController < ApplicationController
  def create
    tempfile = params.dig(:menu, :yml)&.tempfile

    if tempfile && File.extname(tempfile) == '.yml'
      menu = YAML.safe_load_file(tempfile)
    end

    if menu
      flash[:settings_notice] = 'menu loaded from file'
      ImportDishesWorker.perform_async(menu)
    end

    redirect_to new_dishes_path
  end
end
