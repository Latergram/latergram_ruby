# frozen_string_literal: true

RSpec.describe Latergram::Api do
  let(:api_key) { 'example_api_key' }
  let(:default_api_url) { 'https://api.latergr.am/v1' }

  describe '#initialize' do
    context 'when initialized without api_url' do
      subject(:api) { described_class.new(api_key) }

      it { expect(api.api_url).to eq(default_api_url) }
      it { expect(api.api_key).to eq(api_key) }
    end

    context 'when initialized with api_url' do
      subject(:api) { described_class.new(api_key, api_url: api_url) }

      let(:api_url) { 'http://127.0.0.1' }

      it { expect(api.api_url).to eq(api_url) }
      it { expect(api.api_key).to eq(api_key) }
    end
  end

  describe '#publications' do
    subject(:api) { described_class.new(api_key) }

    it { expect(api.publications).to be_an_instance_of(Latergram::Publications) }

    context 'when called multiple times' do
      let!(:publications) { class_double('Latergram::Publications').as_stubbed_const }
      let(:publications_instance) { instance_double('Latergram::Publications') }

      before do
        allow(publications).to receive(:new).and_return(publications_instance)
        2.times { api.publications }
      end

      it 'is initialized only once' do
        expect(publications).to have_received(:new).with(api_key, api_url: default_api_url).once
      end
    end
  end
end
