describe JsonTestData::Number do
  describe ".create" do
    context "normal" do
      let(:object) do
        {
          type: "number"
        }
      end

      it "returns 1" do
        expect(described_class.create(object)).to eql 1
      end
    end

    context "multipleOf constraint" do
      let(:factor) { 2 }
      let(:object) do
        {
          type: "number",
          multipleOf: factor
        }
      end

      it "returns a multiple of the given number" do
        expect(described_class.create(object)).to be_a_multiple_of(factor)
      end
    end

    context "multipleOf constraint" do
      let(:maximum) { 0.5 }
      let(:object) do
        {
          type: "number",
          maximum: maximum
        }
      end

      it "returns a value less than the maximum" do
        expect(described_class.create(object) < maximum).to be true
      end
    end
  end
end
