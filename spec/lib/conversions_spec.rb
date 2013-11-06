require "spec_helper"

describe Conversions do
  describe ".Present" do
    it "nullifies a nil presentee" do
      expect(Conversions::Present(nil)).to be_a(NullObjects::NullPresentee)
    end

    it "returns the presentee as-is when it is non-nil" do
      bob = OpenStruct.new(name: "Bob")
      expect(Conversions::Present(bob)).to eq(bob)
    end
  end

  describe ".Maybe" do
    it "nullifies only nil objects" do
      expect(Conversions::Maybe(nil)).to be_a(NullObjects::NullPresentee)
      expect(Conversions::Maybe(OpenStruct.new)).to eq(OpenStruct.new)
      expect(Conversions::Maybe([])).to eq([])
    end
  end
end
