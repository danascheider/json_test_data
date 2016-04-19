describe JsonTestData::String do
  describe ".create" do
    context "normal" do
      let(:object) do
        {
          type: "string"
        }
      end

      it "returns a string" do
        expect(described_class.create(object)).to be_a String
      end

      it "returns a single character" do
        expect(described_class.create(object).length).to eq 1
      end
    end

    context "with maximum length" do
      let(:object) do
        {
          type: "string",
          maxLength: 2
        }
      end

      it "returns a string 2 characters long" do
        expect(described_class.create(object).length).to eq 2
      end
    end

    context "with minimum length" do
      let(:object) do
        {
          type: "string",
          minLength: 8
        }
      end

      it "returns an 8-character string" do
        expect(described_class.create(object).length).to eq 8
      end
    end
  end
end
