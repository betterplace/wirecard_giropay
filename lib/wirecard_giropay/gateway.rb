module WirecardGiropay
  class Gateway
    attr_reader :business_case_signature, :username, :password

    def initialize(opts = {})
      @business_case_signature = opts.fetch(:business_case_signature)
      @username = opts.fetch(:username)
      @password = opts.fetch(:password)
    end

    def online_wire(params)
      request  = Request.new params.merge(business_case_signature: business_case_signature)
      response = Typhoeus.post(WirecardGiropay.gateway_url, body: request.to_xml, userpwd: http_auth_credentials)
      Response.from_xml response.body
    end

    private

    def http_auth_credentials
      WirecardGiropay.sandboxed? ? WirecardGiropay.sandbox_credentials : [username, password].join(':')
    end
  end
end
