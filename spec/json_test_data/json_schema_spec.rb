describe JsonTestData::JsonSchema do
  describe "#initialize" do

    let(:schema) do
      {
        :"$schema"    => "http://json-schema.org/draft-04/schema#",
        :type         => "object",
        :properties   => {}
      }.to_json
    end

    it "instantiates with a schema" do
      json_schema = JsonTestData::JsonSchema.new(schema)
      expect(json_schema.schema).to eql JSON.parse(schema, symbolize_names: true)
    end
  end

  describe "#generate_example" do
    describe "trivial examples" do
      context "when schema describes an object" do
        let(:schema) do
          JsonTestData::JsonSchema.new(
            {
              :"$schema"    => "http://json-schema.org/draft-04/schema#",
              :type         => "object",
              :properties   => {}
            }.to_json
          )
        end

        let(:output) do
          {}.to_json
        end

        it "generates an object" do
          expect(schema.generate_example).to eql output
        end
      end

      context "when schema describes an array" do
        let(:schema) do
          JsonTestData::JsonSchema.new(
            {
              :"$schema" => "http://json-schema.org/draft-04/schema#",
              :type      => "array",
              :items     => {}
            }.to_json
          )
        end

        let(:output) do
          [nil].to_json
        end

        it "generates an array" do
          expect(schema.generate_example).to eql output
        end
      end
    end

    describe "bigger examples" do
      context "when schema describes an object" do

        let(:schema) do
          {
            :"$schema"  => "http://json-schema.org/draft-04/schema#",
            :type       => "object",
            :properties => {
              :name => {
                :type => "number"
              }
            }
          }.to_json
        end

        it "generates an object" do
          output = JsonTestData::JsonSchema.new(schema).generate_example
          expect(JSON.parse(output)).to be_a Hash
        end

        it "contains the right type of objects" do
          output = JsonTestData::JsonSchema.new(schema).generate_example
          expect(JSON.parse(output).fetch("name")).to be_a(Numeric)
        end
      end

      context "when schema describes an array" do
        let(:schema) do
          {
            :"$schema" => "http://json-schema.org/draft-04/schema#",
            :type      => "array",
            :items     => {
              :type => "number"
            }
          }.to_json
        end

        it "generates an array" do
          json_schema = JsonTestData::JsonSchema.new(schema)
          expect(JSON.parse(json_schema.generate_example)).to be_a Array
        end

        it "contains the right kind of objects" do
          array = JSON.parse(JsonTestData::JsonSchema.new(schema).generate_example)
          all_numbers = array.all? {|item| item.is_a?(Numeric) }
          expect(all_numbers).to be true
        end
      end
    end

    describe "data type support" do
      context "numbers" do

        let(:schema) do
          {
            :"$schema"  => "http://json-schema.org/draft-04/schema#",
            :type       => "object",
            :properties => {
              :id => {
                :type => "number"
              }
            }
          }.to_json
        end

        it "uses the correct data type" do
          example = JsonTestData::JsonSchema.new(schema).generate_example
          expect(JSON.parse(example).fetch("id")).to be_a Numeric
        end
      end

      context "booleans" do

        let(:schema) do
          {
            :"$schema"  => "http://json-schema.org/draft-04/schema#",
            :type       => "object",
            :properties => {
              :admin => {
                :type => "boolean"
              }
            }
          }.to_json
        end

        let(:output) do
          {:admin => true}.to_json
        end

        it "uses the correct data type" do
          json_schema = JsonTestData::JsonSchema.new(schema)
          expect(json_schema.generate_example).to eql output
        end
      end

      context "nested objects" do
        let(:schema) do
          {
            :"$schema" => "http://json-schema.org/draft-04/schema#",
            :type      => "array",
            :items     => {
              :type       => "object",
              :properties => {
                :id => {
                  :type => "number"
                }
              }
            }
          }.to_json
        end

        it "nests the object" do
          example = JSON.parse(JsonTestData::JsonSchema.new(schema).generate_example)
          aggregate_failures do
            expect(example).to be_a Array
            expect(example.first).to be_a Hash
            expect(example.first.fetch("id")).to be_a Numeric
          end
        end
      end

      context "nested arrays" do
        let(:schema) do
          {
            :"$schema"  => "http://json-schema.org/draft-04/schema#",
            :type       => "object",
            :properties => {
              :users => {
                :type  => "array",
                :items => {
                  :type => "number"
                }
              }
            }
          }.to_json
        end

        let(:output) do
          {:users => [1]}.to_json
        end

        it "nests the object" do
          example = JSON.parse(JsonTestData::JsonSchema.new(schema).generate_example)
          aggregate_failures do
            expect(example).to be_a Hash
            expect(example.fetch("users")).to be_a Array
            expect(example.fetch("users").first).to be_a Numeric
          end
        end
      end

      context "arrays in arrays" do
        let(:schema) do
          {
            :"$schema"  => "http://json-schema.org/draft-04/schema#",
            :type       => "array",
            :items => {
              :type => "array",
              :items => {
                :type => "number"
              }
            }
          }.to_json
        end

        it "returns a nested array" do
          example = JSON.parse(JsonTestData::JsonSchema.new(schema).generate_example)
          aggregate_failures do
            expect(example).to be_a Array
            expect(example.first).to be_a Array
            expect(example.first.first).to be_a Numeric
          end
        end
      end
    end

    describe "arrays with constraints" do
      context "array with minimum number of items" do
        let(:schema) do
          {
            :"$schema" => "http://json-schema.org/draft-04/schema#",
            :type      => "array",
            :minItems  => 3
          }.to_json
        end

        it "returns an array of the correct length" do
          json_schema = JsonTestData::JsonSchema.new(schema)
          expect(json_schema.generate_example).to eql [nil, nil, nil].to_json
        end
      end
    end
  end
end
