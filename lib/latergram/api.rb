# frozen_string_literal: true

require 'latergram/social_posts'

module Latergram
  class Api
    attr_reader :api_key, :api_url

    API_URL = 'https://api.latergr.am/v1'

    def initialize(api_key, api_url: API_URL)
      @api_key = api_key
      @api_url = api_url
    end

    def social_posts
      @social_posts ||= SocialPosts.new(api_key, api_url: api_url)
    end
  end
end
