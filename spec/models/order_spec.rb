require "rails_helper"

RSpec.describe Order do
  describe "validations" do
    it { should have_and_belong_to_many(:ingredients) }
  end
end
