require 'sinatra/base'
require_relative 'initializers/initialize'
require_relative 'clients/gpt'
require_relative 'services/ai/process_prompt'


class App < Sinatra::Application
  set :port, 4567
  set :logging, true

  before do
    request.body.rewind

    @request_body = JSON.parse(request.body.read)
  end

  post '/ai_books' do
    gpt = Clients::Gpt.new(api_key: ENV["OPENAI_API_KEY"])
    service = Services::AI::ProcessPrompt.new(ai: gpt)
    result = service.execute(prompt: @request_body["prompt"])

    result.last.content
  end

  run! if app_file == $0
end
