# frozen_string_literal: true

RSpec.describe Latergram::Publications do
  subject(:publications) { described_class.new(api_key, api_url: api_url) }

  let(:api_url) { 'https://api.latergr.am/v1' }
  let(:api_key) { 'test_api_key' }

  describe '#all' do
    let(:expected_result) do
      {
        'data' => [
          {
            'id' => '98',
            'type' => 'publication',
            'attributes' => {
              'text' => 'test1',
              'created_at' => '2019-10-30T20:54:14.960+01:00',
              'updated_at' => '2019-10-30T20:54:15.011+01:00',
              'status' => 'new',
              'published_at' => '2019-10-30T20:59:14.000+01:00'
            }
          },
          {
            'id' => '95',
            'type' => 'publication',
            'attributes' => {
              'text' => 'test2',
              'created_at' => '2019-10-29T22:46:35.857+01:00',
              'updated_at' => '2019-10-29T23:46:41.645+01:00',
              'status' => 'published',
              'published_at' => '2019-10-29T23:46:35.000+01:00'
            }
          }
        ],
        'links' => {
          'first' => 'https://api.latergr.am/v1/publications?page=1&per_page=2',
          'last' => 'https://api.latergr.am/v1/publications?page=26&per_page=2',
          'next' => 'https://api.latergr.am/v1/publications?page=2&per_page=2'
        },
        'meta' => { 'total' => 51 }
      }
    end

    it do
      VCR.use_cassette('publications_all') do
        expect(publications.all(per_page: 2)).to eq(expected_result)
      end
    end
  end

  describe '#find' do
    let(:expected_result) do
      {
        'data' => {
          'id' => '95',
          'type' => 'publication',
          'attributes' => {
            'text' => 'test2',
            'created_at' => '2019-10-29T22:46:35.857+01:00',
            'updated_at' => '2019-10-29T23:46:41.645+01:00',
            'status' => 'published',
            'published_at' => '2019-10-29T23:46:35.000+01:00'
          }
        }
      }
    end

    it do
      VCR.use_cassette('publications_find') do
        expect(publications.find(95)).to eq(expected_result)
      end
    end
  end

  describe '#create' do
    let(:create_parameters) do
      {
        text: 'example text',
        image_urls: ['https://example.com/image.jpg']
      }
    end
    let(:expected_result) do
      {
        'data' => {
          'id' => '99',
          'type' => 'publication',
          'attributes' => {
            'text' => 'example text',
            'created_at' => '2019-10-30T23:54:12.147+01:00',
            'updated_at' => '2019-10-30T23:54:12.192+01:00',
            'status' => 'new',
            'published_at' => '2045-06-01T12:05:00.000+01:00'
          }
        }
      }
    end

    it do
      VCR.use_cassette('publications_create') do
        expect(publications.create(create_parameters)).to eq(expected_result)
      end
    end
  end

  describe '#update' do
    let(:expected_result) do
      {
        'data' => {
          'id' => '99',
          'type' => 'publication',
          'attributes' => {
            'text' => 'another text',
            'created_at' => '2019-10-30T23:54:12.147+01:00',
            'updated_at' => '2019-10-31T00:01:58.128+01:00',
            'status' => 'new',
            'published_at' => '2045-06-01T12:05:00.000+01:00'
          }
        }
      }
    end

    it do
      VCR.use_cassette('publications_update') do
        expect(publications.update(99, text: 'another text')).to eq(expected_result)
      end
    end
  end

  describe '#destroy' do
    let(:expected_result) do
      {
        'data' => {
          'id' => '99',
          'type' => 'publication',
          'attributes' => {
            'text' => 'another text',
            'created_at' => '2019-10-30T23:54:12.147+01:00',
            'updated_at' => '2019-10-31T00:03:30.973+01:00',
            'status' => 'to_be_deleted',
            'published_at' => '2045-06-01T12:05:00.000+01:00'
          }
        }
      }
    end

    it do
      VCR.use_cassette('publications_destroy') do
        expect(publications.destroy(99)).to eq(expected_result)
      end
    end
  end
end
