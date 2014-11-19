require 'wirecard_giropay/version'

module WirecardGiropay
  SANDBOX_URL = 'https://c3-test.wirecard.com/secure/ssl-gateway'
  LIVE_URL    = 'https://c3.wirecard.com/secure/ssl-gateway'

  def self.sandbox!
    @sandboxed = true
  end

  def self.sandboxed?
    !!@sandboxed
  end

  def self.gateway_url
    sandboxed? ? SANDBOX_URL : LIVE_URL
  end
end
