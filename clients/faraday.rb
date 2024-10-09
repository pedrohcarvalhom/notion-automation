require 'faraday'
require_relative 'base_http'

module Clients
  class FaradayHttp < BaseHttp
    def initialize(base_url:, base_headers: {})
      @client = Faraday.new(url: base_url, headers: base_headers)
    end

    def get(endpoint:, query: {}, headers: {})
      @client.get(endpoint, query, headers)
    end

    def post(endpoint:, body: {}, headers: {})
      @client.post(endpoint, body.to_json, headers)
    end

    private

    def merge_headers(headers)
      @headers.merge!(headers)
    end
  end
end
