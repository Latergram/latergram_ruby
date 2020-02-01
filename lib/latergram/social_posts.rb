# frozen_string_literal: true

require 'latergram/requester'
require 'time'

module Latergram
  class SocialPosts
    attr_reader :api_key, :api_url

    ENDPOINT = 'social_posts'

    def initialize(api_key, api_url:)
      @api_key = api_key
      @api_url = api_url
    end

    def all(page: 1, per_page: 10)
      response = requester.get(ENDPOINT, page: page, per_page: per_page)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def find(social_post_id)
      response = requester.get(ENDPOINT + "/#{social_post_id}")

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def create(text:, image_urls: [])
      check_images(image_urls)

      parameters = { social_post: { text: text, image_urls: image_urls }.compact }
      response = requester.post(ENDPOINT, parameters)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def update(social_post_id, text: nil)
      parameters = { social_post: { text: text }.compact }
      response = requester.put(ENDPOINT + "/#{social_post_id}", parameters)

      raise Latergram::Error, response.body unless response.status == 200

      JSON.parse(response.body)
    end

    def destroy(social_post_id)
      response = requester.delete(ENDPOINT + "/#{social_post_id}")

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
