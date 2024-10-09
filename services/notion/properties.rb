require_relative 'property'

module Services::Notion
  ##
  # This class represents the properties of a Notion database object (you can think as each row of the table)
  #
  # @see https://developers.notion.com/reference/property-object
  class Properties
    attr_reader :columns

    def initialize(properties)
      @columns = properties.transform_values { |value| Services::Notion::Property.new(value) }
    end

    def [](key)
      @columns[key]
    end
  end
end
