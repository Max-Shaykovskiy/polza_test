# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @ingredients = Ingredient.all
  end

  def create
    order = Order.new
    order.ingredients = Ingredient.where id: params[:ingredient_ids]

    flash[:settings_notice] = if order.save!
                                'order created'
                              else
                                'order not created'
                              end

    redirect_to new_orders_path
  end

  def cooking_order
    cooking_order = CookingOrderService.new(Order.all, Dish.all).call

    render json: cooking_order.to_json
  end
end
