# frozen_string_literal: true

require 'latergram/requester'
require 'time'

module Latergram
  class Publications
    attr_reader :api_key, :api_url

    ENDPOINT = 'publications'

    def initialize(api_key, api_url:)
      @api_key = api_key
      @api_url = api_url
    end

    def all(page: 1, per_page: 10)
      response = requester.get(ENDPOINT, page: page, per_page: per_page)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def find(publication_id)
      response = requester.get(ENDPOINT + "/#{publication_id}")

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def create(text:, image_urls: [])
      check_images(image_urls)

      parameters = { publication: { text: text, image_urls: image_urls }.compact }
      response = requester.post(ENDPOINT, parameters)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def update(publication_id, text: nil)
      parameters = { publication: { text: text }.compact }
      response = requester.put(ENDPOINT + "/#{publication_id}", parameters)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def destroy(publication_id)
      response = requester.delete(ENDPOINT + "/#{publication_id}")

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    private

    def check_images(image_urls)
      raise(Latergram::Error, 'image_urls must be array') unless image_urls.is_a?(Array)
    end

    def requester
      @requester ||= Requester.new(api_key, api_url)
    end
  end
end
