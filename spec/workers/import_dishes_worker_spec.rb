require "rails_helper"

RSpec.describe ImportDishesWorker, type: :worker do
  let(:worker) { subject }

  it 'imports yml into the menu' do
    menu = {"ingredients"=>["ряженка", "йогурт 2%"],
            "dishes"=>[{"name"=>"Запеканка с зеленой гречкой и сыром",
                        "ingredients"=>["фарш курино-мясной", "ваниль"]}]}

    expect { worker.perform menu }.to change(Ingredient, :count).by(4)
                                  .and change(Dish, :count).by(1)
  end
end
