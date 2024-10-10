require 'openai'
require_relative 'ai'
require_relative '../tools/notion_tool'

module Clients
  class Gpt < Ai
    def initialize(api_key:, options: {})
      Langchain.logger.level = Logger::ERROR
      default_options = { temperature: 0.2, chat_completion_model_name: "gpt-3.5-turbo" }
      llm_options = options.merge(default_options)

      @llm = Langchain::LLM::OpenAI.new(
        api_key: ENV["OPENAI_API_KEY"],
        default_options: llm_options
      )
    end

    ##
    # @param prompt [String]
    # @param options [Hash] See {Langchain::Assistant#add_message_and_run}
    def assist(prompt:, **options, &block)
      instructions = options[:instructions]
      tool = Tools::NotionTool.new(notion_api_key: ENV["NOTION_API_KEY"], notion_base_url: ENV["NOTION_BASE_URL"])

      assistant = Langchain::Assistant.new(
        llm: @llm,
        instructions: instructions,
        tools: [tool],
      ) do |response_chunk|
        delta = response_chunk["delta"]

        if delta && delta["content"]
          yield(delta["content"]) if block_given?
        end
      end

      assistant.add_message_and_run(content: prompt, auto_tool_execution: true)
    end
  end
end
