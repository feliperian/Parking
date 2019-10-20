require 'rails_helper'

RSpec.describe Parking, type: :model do
  it { should validate_presence_of(:plate) }
  it "has a valid factory" do
    expect(parking).to be_valid
  end
end
