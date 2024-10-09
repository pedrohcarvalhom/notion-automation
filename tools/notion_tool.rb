require 'langchain'
require_relative '../clients/faraday'
require_relative '../services/notion/load_database'

module Tools
  class NotionTool
    extend Langchain::ToolDefinition

    define_function :search_books, description: "Busca por todos os livros no Notion a partir do ID do banco de dados fornecido" do
      property :id, type: "string", description: "ID do banco de dados a ser buscado", required: true
    end

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

    def search_books(id:)
      @search_service.query_database(id:, structure_to_hash: true)
    end
  end
end
