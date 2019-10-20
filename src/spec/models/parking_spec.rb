require 'rails_helper'

RSpec.describe Parking, type: :model do
  it { should validate_presence_of(:plate) }
  it "has a valid factory" do
    expect(create(:parking)).to be_valid
  end
  it "when plate is invalid" do
    expect { create(:parking, plate: "999-AAAA") }.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: Plate It must be like AAA-9999.')
  end
end
