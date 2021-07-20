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

    def create(text:, images:)
      check_images(images)

      parameters = { publication: { text: text, images: images }.compact }
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

    def check_images(images)
      raise(Latergram::Error, 'images must be array') unless images.is_a?(Array)
      raise(Latergram::Error, 'images cannot be empty') if images.empty?

      return if images.all? { |image| image.key?(:data) && image.key?(:filename) && image.key?(:content_type) }

      raise(
        Latergram::Error,
        'images must contain the following attributes: data (base64 encoded image), filename and content_type'
      )
    end

    def requester
      @requester ||= Requester.new(api_key, api_url)
    end
  end
end
