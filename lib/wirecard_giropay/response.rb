module WirecardGiropay
  class Response

    def initialize(xml)
      @xml = xml
    end

    def self.from_xml(xml)
      new xml
    end

    # Implements the ActiveMerchant interface
    def params
      {
        success: success?,
        redirect_html: redirect_html,
        status_code: status_code,
        reason_code: reason_code,
        guwid: guwid
      }
    end

    # Implements the ActiveMerchant interface
    def message
    end

    # Implements the ActiveMerchant interface
    def success?
      status_code == 'O20'
    end

    private

    def redirect_html
      return '' unless success?
      template_html = File.read File.expand_path('../../../templates/redirect.html', __FILE__)
      template_html.gsub /%\{\w+\}/, replace_params
    end

    def status_code
      xml_doc.xpath('//PROCESSING_STATUS/StatusCode').text
    end

    def reason_code
      xml_doc.xpath('//PROCESSING_STATUS/ReasonCode').text
    end

    def guwid
      xml_doc.xpath('//PROCESSING_STATUS/GuWID').text
    end

    def replace_params
      {
        '%{redirect_url}'    => redirect_url,
        '%{redirect_params}' => redirect_params
      }
    end

    def redirect_url
      xml_doc.xpath('//REDIRECT_BANK_DATA/Url').text
    end

    def redirect_params
      xml_doc.xpath('//REDIRECT_BANK_DATA/Parameters').text
    end

    def xml_doc
      @xml_doc ||= Nokogiri::XML @xml
    end

  end
end
