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
    end

    context "number greater than or equal to maximum" do
    end
  end
end
