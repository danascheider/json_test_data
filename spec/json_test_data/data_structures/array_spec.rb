describe JsonTestData::Array do
  describe ".create" do
    context "normal" do
      let(:object) do
        {
          type: "array"
        }
      end

      it "creates an empty array" do
        expect(described_class.create(object)).to eql []
      end
    end
  end
end
