describe JsonTestData::Number do
  describe ".create" do
    context "normal" do
      let(:object) do
        {
          type: "number"
        }
      end

      it "returns a number" do
        expect(described_class.create(object)).to be_a Numeric
      end
    end

    context "multipleOf constraint" do
      let(:factor) { 2 }
      let(:object) do
        {
          type: "number",
          multipleOf: 2
        }
      end

      it "returns a multiple of the given number" do
        expect(described_class.create(object)).to be_a_multiple_of(2)
      end
    end

    context "maximum constraint" do
      let(:maximum) { 0.5 }
      let(:object) do
        {
          type: "number",
          maximum: maximum
        }
      end

      it "returns a value less than the maximum" do
        expect(described_class.create(object)).to be_less_than_or_equal_to(maximum)
      end
    end

    context "minimum constraint" do
      let(:minimum) { 2 }
      let(:object) do
        {
          type: "number",
          minimum: minimum
        }
      end

      it "returns a value greater than the minimum" do
        expect(described_class.create(object)).to be_greater_than_or_equal_to(minimum)
      end
    end

    context "multiple constraints" do
      context "maximum and minimum" do
        let(:maximum) { 1 }
        let(:minimum) { 0 }
        let(:object) do
          {
            type: "number",
            minimum: minimum,
            maximum: maximum,
            exclusiveMinimum: true
          }
        end

        it "returns a value between the maximum and the minimum" do
          aggregate_failures do
            expect(described_class.create(object)).to be_greater_than(minimum)
            expect(described_class.create(object)).to be_less_than_or_equal_to(maximum)
          end
        end
      end

      context "minimum and multiple" do
        let(:factor) { 2 }
        let(:minimum) { 3 }
        let(:object) do
          {
            type: "number",
            multipleOf: factor,
            minimum: minimum
          }
        end

        it "returns the next lowest multiple" do
          aggregate_failures do
            expect(described_class.create(object)).to be_a_multiple_of(factor)
            expect(described_class.create(object)).to be_greater_than(minimum)
          end
        end
      end

      context "minimum not a multiple of multiple" do
        let(:minimum) { 3 }
        let(:factor) { 5 }
        let(:object) do
          {
            type: "number",
            minimum: minimum,
            multipleOf: factor
          }
        end

        it "returns a multiple of the given factor" do
          expect(described_class.create(object)).to be_a_multiple_of(factor)
        end

        it "returns a number higher than the minimum" do
          expect(described_class.create(object)).to be_greater_than_or_equal_to(minimum)
        end
      end
    end
  end
end
