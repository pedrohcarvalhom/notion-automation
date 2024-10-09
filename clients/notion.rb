module Clients
  class Notion
    def initialize(client: ::Notion::Client.new)
      @client = client
    end

    ## Query a database
    def database(id:, &block)
      @client.database_query(database_id: id) do |page|
        block.call(page)
      end
    end
  end
end
