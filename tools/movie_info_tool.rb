module Tools
  class MovieInfoTool
    extend Langchain::ToolDefinition

    define_function :search_movie, description: "Search for a movie" do
      property :query, type: "string", description: "The movie title to search for", required: true
    end

    def initialize(api_key:)
      @api_key = api_key
    end

    def search_movie(query:)
      ["movies", "search", query].join("/")
    end
  end
end
