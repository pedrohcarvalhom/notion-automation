require_relative 'row'
require_relative 'properties'

module Services
  module Notion
    class LoadDatabase
      def initialize(http_client:)
        @http_client = http_client
      end

      def query_database(id:, structure_to_hash: false)
        endpoint = "/v1/databases/#{id}/query"
        response = @http_client.post(endpoint: endpoint)

        res = JSON.parse(response.body)
        mapped = res["results"].map { |page| build_database(page) }

        return mapped unless structure_to_hash

        to_hash_format(mapped)
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

      def to_hash_format(rows)
        rows_properties = rows.map(&:properties)
        rows_properties.each_with_object({}) do |properties, hash|
          columns = properties.columns
          title_column = columns.values.find { |column| column.type == "title" }&.value

          hash[title_column] = columns.keys.each_with_object({}) do |key, sub_hash|
            sub_hash[key.downcase.gsub(" ", "_").to_sym] = columns[key].value
          end
        end
      end
    end
  end
end
