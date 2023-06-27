require "rails_helper"

RSpec.describe Ingredient do
  describe "validations" do
    subject { Ingredient.create name: 'name' }

    it { should have_and_belong_to_many(:orders) }
    it { should have_and_belong_to_many(:dishes) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end
end
