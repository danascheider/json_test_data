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

    context "with enum" do
      let(:enum) { ["foo", "bar", "baz"] }

      let(:object) do
        {
          type: "string",
          enum: enum
        }
      end

      it "returns a string from the list" do
        expect(described_class.create(object)).to be_in enum
      end
    end

    context "with a pattern" do
      let(:object) do
        {
          type: "string",
          pattern: '\d{2,}.*'
        }
      end

      it "returns a string" do
        expect(described_class.create(object)).to be_a String
      end

      it "returns a string of numbers" do
        expect(described_class.create(object)).to match(/\d+/)
      end
    end

    context "with a format" do
      context "date-time" do
        let(:object) do
          {
            type: "string",
            format: "date-time"
          }
        end

        let(:datetime_pattern) do
          /^\d{4}(\-\d{2}){2}T\d{2}\:\d{2}\:\d{2}(Z|[\+\-]\d{2}\:\d{2})$/
        end

        it "generates a valid datetime" do
          expect(described_class.create(object)).to match(datetime_pattern)
        end
      end

      context "email" do
        let(:object) do
          {
            type: "string",
            format: "email"
          }
        end

        let(:email_pattern) do
          /^\S+@\S+\.\S{1,5}$/
        end

        it "generates a valid e-mail" do
          expect(described_class.create(object)).to match(email_pattern)
        end
      end

      context "hostname" do
        let(:object) do
          {
            type: "string",
            format: "hostname"
          }
        end

        let(:hostname_pattern) do
          /^[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9]$/
        end

        it "generates a valid hostname" do
          expect(described_class.create(object)).to match(hostname_pattern)
        end
      end

      context "uri" do
        #
      end
    end
  end
end
