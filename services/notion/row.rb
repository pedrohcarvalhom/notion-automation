module Services
  module Notion
    ##
    # This class represents a Notion database object, witch contains information about each row in the Notion Table.
    #
    # Each row in notion database can be a Page, List or etc.
    #
    # @see https://developers.notion.com/reference/database
    class Row
      attr_reader :object_name, :id, :created_time, :last_edited_time, :title, :description, :properties, :public_url

      def initialize(object_name:, id:, created_time:, last_edited_time:, title:, description:, properties:, public_url:)
        @object_name = object_name
        @id = id
        @created_time = created_time
        @last_edited_time = last_edited_time
        @title = title
        @description = description
        @properties = properties
        @public_url = public_url
      end
    end
  end
end
