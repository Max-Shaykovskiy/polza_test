require "rails_helper"

RSpec.describe DishesController do
  describe 'POST create' do
    it 'redirects to the created order' do
      post :create
      response.should redirect_to(new_dishes_path)
    end

    context 'passing the menu to the importer' do
      it 'transfers menu to the importer' do
        parsed_yaml = {"somekey" => {"someotherkey" => "abc"}}
        filepath = "bogus_filename.yml"
        class String
          def tempfile
            "bogus_filename.yml"
          end
        end

        allow(YAML).to receive(:safe_load_file).with(filepath).and_return(parsed_yaml)
        allow(ImportDishesWorker).to receive(:perform_async).with(parsed_yaml)

        post :create, params: {menu: {yml: 'uploadedfile'}}

        expect(YAML).to have_received(:safe_load_file).with(filepath).once
        expect(ImportDishesWorker).to have_received(:perform_async).with(parsed_yaml).once
      end

      it 'does not pass menu to importer when file is not yml' do
        class String
          def tempfile
            "bogus_filename.png"
          end
        end

        post :create, params: {menu: {yml: 'uploadedfile'}}

        expect(YAML).to_not receive(:safe_load_file)
        expect(ImportDishesWorker).to_not receive(:perform_async)
      end
    end
  end
end
