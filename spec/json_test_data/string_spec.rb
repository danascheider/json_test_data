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
  end
end
