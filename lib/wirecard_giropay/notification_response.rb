module WirecardGiropay
  class NotificationResponse

    def initialize(xml)
      @xml = xml
    end

    def self.from_xml(xml)
      new xml
    end

    def success?
      status_code == 'O10'
    end

    def failed?
      status_code == 'O30'
    end

    private

    def status_code
      @status_code ||= xml_doc.xpath('//Notification/ReferenceStatusCode').text
    end

    def xml_doc
      @xml_doc ||= Nokogiri::XML @xml
    end

  end
end

