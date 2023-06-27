require "rails_helper"

RSpec.describe OrdersController do
  describe 'POST create' do
    it "redirects to the new orders path" do
      post :create
      response.should redirect_to(new_orders_path)
    end

    it 'creates a new Order' do
      ingredient_id_1 = (Ingredient.create name: 'ingredient1').id
      ingredient_id_2 = (Ingredient.create name: 'ingredient2').id

      expect {
          post :create,
               params: {ingredient_ids: [ingredient_id_1, ingredient_id_2]}
        }.to change(Order, :count).by(1)
    end
  end

  describe 'GET cooking_order' do
    it 'render json response' do
      allow(CookingOrderService).to receive_message_chain(:new, :call)
      get :cooking_order
      response.header['Content-Type'].should include 'application/json'
    end
  end
end
