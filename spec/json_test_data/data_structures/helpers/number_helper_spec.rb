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

    context "step size greater than 1" do
      let(:number) { 3 }
      let(:maximum) { 3 }
      let(:step_size) { 2 }

      it "returns the number reduced by step size" do
        expect(
          adjust_for_maximum(number: number, maximum: maximum, step_size: step_size)
        ).to eql number - step_size
      end
    end

    context "step size less than 1" do
      let(:number) { 3 }
      let(:maximum) { 3 }
      let(:step_size) { 0.25 }

      it "returns the number reduced by step size" do
        expect(
          adjust_for_maximum(number: number, maximum: maximum, step_size: step_size)
        ).to eql number - step_size
      end
    end
  end

  describe "#adjust_for_minimum" do
    context "no minimum" do
      let(:number) { 1 }

      it "returns the given number" do
        expect(adjust_for_minimum(number: number)).to eql number
      end
    end
  end
end
