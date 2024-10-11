require 'sinatra/base'
require 'sinatra/streaming'
require_relative 'initializers/initialize'
require_relative 'clients/gpt'
require_relative 'services/ai/process_prompt'


class App < Sinatra::Application
  helpers Sinatra::Streaming
  set :port, 4567
  set :logging, true

  configure do
    enable :cross_origin
  end

  before do
    if request.env['REQUEST_METHOD'] == 'POST'
      request.body.rewind

      @request_body = JSON.parse(request.body.read)
    end
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token, Import-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end


  post '/ai_books' do
    gpt = Clients::Gpt.new(api_key: ENV["OPENAI_API_KEY"])
    service = Services::AI::ProcessPrompt.new(ai: gpt)

    stream do |out|
      service.execute(prompt: @request_body["prompt"]) do |content|
        out << content

        out.flush
      end
    end
  end

  run! if app_file == $0
end
