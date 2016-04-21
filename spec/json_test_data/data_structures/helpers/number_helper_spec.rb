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
        ).to eql maximum - step_size
      end
    end

    context "step size less than 1" do
      let(:number) { 3 }
      let(:maximum) { 3 }
      let(:step_size) { 0.25 }

      it "returns the number reduced by step size" do
        expect(
          adjust_for_maximum(number: number, maximum: maximum, step_size: step_size)
        ).to eql maximum - step_size
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

    context "number is greater than minimum" do
      let(:number) { 1 }
      let(:minimum) { 0 }

      it "returns the number" do
        expect(adjust_for_minimum(number: number, minimum: minimum)).to eql number
      end
    end

    context "number is less than or equal to minimum" do
      let(:number) { 2 }
      let(:minimum) { 2 }

      it "returns one more than the minimum" do
        expect(adjust_for_minimum(number: number, minimum: minimum)).to eql minimum + 1
      end
    end

    context "step size greater than 1" do
      let(:number) { 2 }
      let(:minimum) { 2 }
      let(:step_size) { 2 }

      it "returns the number increased by step size" do
        expect(
          adjust_for_minimum(number: number, minimum: minimum, step_size: step_size)
        ).to eql minimum + step_size
      end
    end

    context "step size less than 1" do
      let(:number) { 2 }
      let(:minimum) { 2 }
      let(:step_size) { 0.5 }

      it "returns the number reduced by step size" do
        expect(
          adjust_for_minimum(number: number, minimum: minimum, step_size: step_size)
        ).to eql minimum + step_size
      end
    end
  end

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
end
