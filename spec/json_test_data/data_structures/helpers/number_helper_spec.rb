describe JsonTestData::NumberHelper do
  include JsonTestData::NumberHelper

  describe "#adjust_for_maximum" do
    context "no maximum" do
      let(:number) { 3 }

      it "returns the given number" do
        expect(adjust_for_maximum(number: number)).to eql number
      end
    end

    context "number less than maximum" do
      let(:number) { 3 }
      let(:maximum) { 4 }

      it "returns the given number" do
        expect(adjust_for_maximum(number: number, maximum: maximum)).to eql number
      end
    end

    context "number greater than or equal to maximum" do
      let(:number) { 3 }
      let(:maximum) { 3 }

      it "returns one less than the maximum" do
        expect(adjust_for_maximum(number: number, maximum: maximum)).to eql maximum - 1
      end
    end
  end
end
