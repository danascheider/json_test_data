describe JsonTestData::NumberHelper do
  include JsonTestData::NumberHelper

  describe "#between" do
    context "when it doesn't have to be an integer" do
      let(:min) { 1 }
      let(:max) { 2 }
      let(:result) { 1.5 }

      it "returns the mean" do
        expect(between(min: min, max: max)).to be_within(0.0002).of(result)
      end

      it "is less than the max" do
        expect(between(min: min, max: max)).to be_less_than(max)
      end

      it "is greater than the min" do
        expect(between(min: min, max: max)).to be_greater_than(min)
      end
    end

    context "when it has to be an integer" do
      let(:min) { 2 }
      let(:max) { 5 }
      let(:result) { 4 }

      it "returns the nearest integer" do
        expect(between(min: min, max: max, integer: true)).to eql result
      end
    end
  end

  describe "#mean" do
    let(:numbers) { [ 3, 4, 5, 6 ] }
    let(:avg) { 4.5 }

    it "returns the mean" do
      expect(mean(*numbers)).to be_within(0.0002).of(avg)
    end
  end
end
