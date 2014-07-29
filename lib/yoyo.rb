require "yoyo/version"
require 'faraday'

module Yoyo
  class Yo
    # = Yoyo
    #
    # Yoyo is a gem for accessing the YO api. I hope you like it!

    # This is your API token.
    # There are many like it, but this one is yours. See http://dev.justyo.co/
    attr_reader :api_token

    # This is just a reference to the HTTP connection to the YO mothership.
    # I mean API.
    attr_reader :api_connection

    # You're going to need an API token to get started.
    # You can get one from http://dev.justyo.co/
    def initialize(api_token)
      @api_token = api_token
      @api_connection = Faraday.new(:url => "http://api.justyo.co/") do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    # Say YO to someone from your API account
    # Usage: yo("PHILCRISSMAN") 
    # Returns a Faraday response, so you can see the HTTP status and errors, if any
    def yo(some_user)
      api_connection.post "/yo/", { api_token: api_token, username: some_user }
    end

    # Say YO to everyone who has ever YO'd your API account
    # Should return an empty body. YOs all your subscribers
    def yo_all
      api_connection.post "/yoall/", { api_token: api_token }
    end

    # Get the number of subscribers you have. That sounds handy.
    # Does YO document this anywhere? I can't find it.
    # Returns a Faraday response.
    # To get the count, you could:
    # 
    #   require 'JSON'
    #   yo = Yoyo::Yo.new('your-token')
    #   count = yo.subscribers_count
    #   response_hash = JSON.parse(count.body)
    #   response_hash['result']
    #
    # That's not too hard.
    def subscribers_count
      api_connection.get "/subscribers_count/", { api_token: api_token }
    end
  end
end
