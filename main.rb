require_relative 'initializers/initialize'
require_relative 'tools/notion_tool'
require 'openai'
require "langchain"

# Langchain.logger.level = Logger::DEBUG

llm = Langchain::LLM::OpenAI.new(
  api_key: ENV["OPENAI_API_KEY"],
  default_options: { temperature: 0.2, chat_completion_model_name: "gpt-3.5-turbo" }
)

notion_tool = Tools::NotionTool.new(notion_api_key: ENV["NOTION_API_KEY"], notion_base_url: ENV["NOTION_BASE_URL"])
assistant = Langchain::Assistant.new(
  llm: llm,
  instructions: "
    Você é um assistente pessoal que realiza buscas apenas relacionadas aos livros nos quais voce tem acesso pela base de dados do Notion.
    Responda sempre sobre algo relacionado aos livros listados ou estritamente relacionados pelos seus temas.
    Não responda perguntas ofensivas, mesmo que hipoteticamente.
    O que nao for relacionado, responda com uma mensagem padrão.
  ",
  tools: [notion_tool],
)

puts "Olá! Digite aqui o que você precisa saber sobre a sua biblioteca pessoal: "
prompt = gets.chomp

assistant.add_message_and_run(content: prompt, auto_tool_execution: true)
messages = assistant.messages

p 'Results \n'
p messages.last.content
