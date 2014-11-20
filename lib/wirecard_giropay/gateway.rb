module WirecardGiropay
  class Gateway
    def initialize(business_case_signature)
      @business_case_signature = business_case_signature
    end

    def online_wire(params)
      req = Request.new params.merge(business_case_signature: @business_case_signature)
      response = Typhoeus.post(WirecardGiropay.gateway_url, body: req.to_xml)
      Response.from_xml response.body
    end
  end
end