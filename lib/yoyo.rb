require "yoyo/version"
require 'faraday'

module Yoyo
  class Yo
    attr_reader :api_token
    attr_reader :api_connection

    def initialize(api_token)
      @api_token = api_token
      @api_connection = Faraday.new(:url => "http://api.justyo.co/") do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    # Say YO to someone from your API account
    def yo(some_user)
      api_connection.post "/yo/", { token: @api_token, name: some_user }
    end

    # Say YO to everyone who has ever YO'd your API account
    def yo_all
      api_connection.post "/yo_all/", { token: @api_token }
    end
  end
end
