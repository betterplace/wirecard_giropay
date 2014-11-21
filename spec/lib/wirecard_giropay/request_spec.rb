require 'spec_helper'

module WirecardGiropay
  describe Request do
    describe '#initialize' do
      it 'throws an Error on missing params' do
        expect{ Request.new(first_name: 'John') }.to raise_error(Request::InvalidParamsError)
      end
    end

    describe '#to_xml' do
      it 'gives the right xml' do
        params = {
            business_case_signature:    '0000003162752CAC',
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

        req = Request.new params
        expected_xml = File.read File.expand_path('../../../support/sample_request.xml', __FILE__)
        expect(req.to_xml).to eq expected_xml
      end
    end
  end
end
