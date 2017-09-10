require 'spec_helper'

class FakeHandler
  def manages_key?(key); end
  def get_data(key, obj); end
end

RSpec.describe 'Schema custom handler' do
  let(:schema) { File.read('./fixtures/basic_schema.json') }
  let(:result) { JSON.parse(subject.generate_example) }

  subject { JsonTestData::JsonSchema.new(schema, handler) }

  before do
    allow(JsonTestData::Number).to receive(:create).and_return(9000)
  end

  describe 'when custom_handler is not passed' do
    let(:handler) { nil }

    it 'doesnt error' do
      expect{result}.not_to raise_error
    end

    it 'still generates data' do
      expect(result['count']).to eq 9000
    end
  end

  describe 'when handler passed' do
    let(:handler) { FakeHandler.new }

    before do
      allow(handler).to receive(:manages_key?).and_return(false)
    end

    context 'and it manages key' do
      it 'gets data from the handler' do
        expect(handler).to receive(:manages_key?).with(:count).and_return(true)
        expect(handler).to receive(:get_data).with(:count, { type: 'number' }).and_return(5555)
        expect(result['count']).to eq 5555
      end
    end

    context "and it doesn't manage key" do
      it 'returns number test data' do
        expect(handler).to receive(:manages_key?).with(:count).and_return(false)
        allow(handler).to receive(:get_data).and_return(5555)

        expect(result['count']).to eq 9000
        expect(result['user_count']).to eq 9000
      end
    end
  end
end
