module WirecardGiropay
  class Gateway
    def initialize(business_case_signature, username = '', password = '')
      @business_case_signature = business_case_signature
      @username = username
      @password = password
    end

    def online_wire(params)
      req = Request.new params.merge(business_case_signature: @business_case_signature)
      response = Typhoeus.post(WirecardGiropay.gateway_url, body: req.to_xml, userpwd: http_auth_credentials)
      Response.from_xml response.body
    end

    private

    def http_auth_credentials
      WirecardGiropay.sandboxed? ? WirecardGiropay.sandbox_credentials : [@username, @password].join(':')
    end
  end
end