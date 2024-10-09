require 'notion'

Notion.configure do |config|
  config.token = ENV['NOTION_API_KEY']
end
