require "dotenv/load"

if ENV["RUBY_ENV"] == "development"
  require 'debug'
  require 'pry'
  require 'pry-remote'
end
