describe JsonTestData::String do
  describe ".create" do
    context "normal" do
      let(:object) do
        {
          type: "string"
        }
      end

      it "returns 'string'" do
        expect(described_class.create(object)).to eq "string"
      end
    end

    context "with maximum length" do
      let(:object) do
        {
          type: "string",
          maxLength: 2
        }
      end

      it "returns 'st'" do
        expect(described_class.create(object)).to eq "st"
      end
    end
  end
end
