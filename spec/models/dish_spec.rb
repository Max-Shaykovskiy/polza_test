require "rails_helper"

RSpec.describe Dish do
  describe "validations" do
    subject { Dish.create name: 'name' }

    it { should have_and_belong_to_many(:ingredients) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end
end
