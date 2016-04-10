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
  end
end
