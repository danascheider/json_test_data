describe JsonTestData do
  describe "::generate!" do
    context "when schema describes an object" do
      let(:schema) do
        {
          "$schema"    => "http://json-schema.org/draft-04/schema#",
          "type"       => "object",
          "properties" => {}
        }.to_json
      end

      let(:output) do
        {}.to_json
      end

      it "generates an object" do
        expect(JsonTestData.generate!(schema)).to eql output
      end
    end
  end
end
