require_relative 'initializers/initialize'
require_relative 'clients/faraday'
require_relative 'services/notion/client'

http_client = Clients::FaradayHttp.new(
  base_url: ENV['NOTION_BASE_URL'],
  base_headers: { 'Authorization' => "Bearer #{ENV['NOTION_API_KEY']}", 'Notion-Version' => '2022-06-28', 'Content-Type' => 'application/json' }
)

service = Services::Notion::Client.new(http_client: http_client)

service.query_database(id: '11611dfc701e80a9a888f65900e51f9e')

# require "langchain"

# Langchain.logger.level = Logger::DEBUG

# llm = Langchain::LLM::OpenAI.new(
#   api_key: ENV["OPENAI_API_KEY"],
#   default_options: { temperature: 0.5, chat_completion_model_name: "gpt-3.5-turbo" }
# )

# movie_tool = Tools::MovieInfoTool.new(api_key: ENV["OPENAI_API_KEY"])

# assistant = Langchain::Assistant.new(
#   llm: llm,
#   instructions: "You're a movie expert",
#   tools: [movie_tool],
# )

# puts "Please, type a movie title: "
# prompt = gets.chomp

# assistant.add_message_and_run!(content: prompt)
# messages = assistant.messages
# response = messages.last.content

# puts "RESPONSE:\n #{response}"
