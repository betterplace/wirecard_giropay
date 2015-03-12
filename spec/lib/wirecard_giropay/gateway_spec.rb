require 'spec_helper'

module WirecardGiropay
  describe Gateway do
    def read_sample_file(file)
      File.read File.expand_path('../../../support/' + file, __FILE__)
    end

    let(:success_xml) { read_sample_file 'sample_response_success.xml' }
    let(:failure_xml) { read_sample_file 'sample_response_failure.xml' }

    let(:online_wire_params) do
      {
          transaction_mode:           'live',
          transaction_id:             'TNR45122001',
          first_name:                 'John F',
          last_name:                  'Doe',
          account_number:             '12345678',
          bank_code:                  '30020900',
          country:                    'DE',
          amount_in_cents:            '500',
          currency:                   'EUR',
          usage:                      'OrderNo-FT345S71 Thank you',
          success_redirect_url:       'https://www.merchant.com/payment?result=success',
          failure_redirect_url:       'https://www.merchant.com/payment?result=failure',
          redirect_window_name:       'Payment Result',
          notification_url:           'https://www.merchant.com/notification',
          alternate_notification_url: 'mailto:notification@merchant.com',
          order_data:                 {
              'key-1' => 'Project X',
              'key-2' => 'Organisation Y',
          },
      }
    end

    let(:gateway_opts) do
      {
        business_case_signature: '9490000000ABC',
        username: 'foo',
        password: 'bar'
      }
    end

    let(:gateway) { Gateway.new(gateway_opts) }

    describe '#online_wire' do
      before do
        response = Typhoeus::Response.new(code: 200, body: success_xml)
        Typhoeus.stub(WirecardGiropay.gateway_url).and_return(response)
      end

      it 'returns a successful response' do
        response = gateway.online_wire(online_wire_params)
        expect(response).to be_a Response
      end

    end
  end
end
