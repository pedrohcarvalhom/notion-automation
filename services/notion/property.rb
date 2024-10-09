module Services::Notion
  ##
  # This class represents the properties of a Notion database object (you can think as each row of the table). Here we have the
  # content itself, as well as the type of the content (e.g. "select", "title", etc.)
  #
  # @see https://developers.notion.com/reference/property-object
  class Property
    attr_reader :id, :type, :value

    def initialize(property_hash)
      @id = property_hash["id"]
      @type = property_hash["type"]
      @value = extract_value(property_hash)
    end

    private

    def extract_value(property_hash)
      case property_hash["type"]
      when "select"
        property_hash["select"] ? property_hash["select"]["name"] : nil
      when "rich_text"
        property_hash["rich_text"].map { |text| text["plain_text"] }.join(" ")
      when "title"
        property_hash["title"].map { |text| text["plain_text"] }.join(" ")
      when "status"
        property_hash["status"] ? property_hash["status"]["name"] : nil
      when "date"
        { start: property_hash["date"]["start"], end: property_hash["date"]["end"] }
      else
        { unknown: property_hash["type"] }
      end
    end
  end
end
