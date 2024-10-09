require_relative 'row'
require_relative 'properties'

module Services
  module Notion
    class Client
      def initialize(http_client:)
        @http_client = http_client
      end

      def query_database(id:)
        endpoint = "/v1/databases/#{id}/query"
        response = @http_client.post(endpoint: endpoint)

        res = JSON.parse(response.body)
        res["results"].map { |page| build_database(page) }
      end

      private

      def build_database(page)
        Services::Notion::Row.new(
          object_name: page["object"],
          id: page["id"],
          created_time: page["created_time"],
          last_edited_time: page["last_edited_time"],
          title: page["title"],
          description: page["description"],
          properties: Services::Notion::Properties.new(page["properties"]),
          public_url: page["public_url"]
        )
      end
    end
  end
end
