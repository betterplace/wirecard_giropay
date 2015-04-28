require 'spec_helper'

module WirecardGiropay
  describe NotificationResponse do

    def read_sample_file(file)
      File.read File.expand_path('../../../support/' + file, __FILE__)
    end

    let(:notification_success_xml) { read_sample_file 'sample_notification_success.xml' }
    let(:notification_reject_xml)  { read_sample_file 'sample_notification_rejection.xml' }

    describe '#success?' do
      context 'for a successful payment' do
        let(:response) { NotificationResponse.from_xml notification_success_xml }

        it('returns true') { expect(response.success?).to eq true }
      end

      context 'for a rejected payment' do
        let(:response) { NotificationResponse.from_xml notification_reject_xml }

        it('returns false') { expect(response.success?).to eq false }
      end
    end

    describe '#failed?' do
      context 'for a rejected payment' do
        let(:response) { NotificationResponse.from_xml notification_reject_xml }

        it('returns true') { expect(response.failed?).to eq true }
      end

      context 'for a successful payment' do
        let(:response) { NotificationResponse.from_xml notification_success_xml }

        it('returns false') { expect(response.failed?).to eq false }
      end
    end
  end
end
