class CookingOrderService
  def initialize(orders, dishes)
    @orders = orders
    @dishes = dishes
  end

  def call
    dishes = []
    cooking_order = []

    @orders.includes(:ingredients).each do |order|
      @dishes.includes(:ingredients).all.each do |dish|
        next if (dish.ingredients & order.ingredients).present?

        dishes << dish
      end
    end

    dishes.group_by(&:name).sort_by { |_key, value| -value.length }
          .each do |key, value|
      cooking_order << { name: key, count: value.length }
    end

    cooking_order
  end
end
