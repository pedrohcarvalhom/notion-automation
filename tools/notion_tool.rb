require 'langchain'
require_relative '../clients/faraday'
require_relative '../services/notion/load_database'

module Tools
  class NotionTool
    extend Langchain::ToolDefinition

    define_function :search_books, description: "Busca por livros no Notion"

    def initialize(notion_api_key:, notion_base_url:)
      @notion_api_key = notion_api_key
      client = Clients::FaradayHttp.new(
        base_url: notion_base_url,
        base_headers: {
          'Authorization' => "Bearer #{notion_api_key}",
          'Notion-Version' => '2022-06-28',
          'Content-Type' => 'application/json'
        }
      )
      @search_service = Services::Notion::LoadDatabase.new(http_client: client)
    end

    def search_books
      @search_service.query_database(id: '11611dfc701e80a9a888f65900e51f9e', structure_to_hash: true)
    end
  end
end
