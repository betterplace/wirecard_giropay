require 'spec_helper'

describe 'WirecardGiropay' do
  describe '.gateway_url' do
    it 'returns the live system url' do
      expect(WirecardGiropay.gateway_url).to eq 'https://c3.wirecard.com/secure/ssl-gateway'
    end
  end

  context 'when running in sandbox mode' do
    before { WirecardGiropay.sandbox! }

    it 'returns the live system url' do
      expect(WirecardGiropay.gateway_url).to eq 'https://c3-test.wirecard.com/secure/ssl-gateway'
    end
  end
end
