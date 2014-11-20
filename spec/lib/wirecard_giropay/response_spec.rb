require 'spec_helper'

module WirecardGiropay
  describe Response do

    def read_sample_file(file)
      File.read File.expand_path('../../../support/' + file, __FILE__)
    end

    let(:success_xml)      { read_sample_file 'sample_response_success.xml' }
    let(:failure_xml)      { read_sample_file 'sample_response_failure.xml' }
    let(:redirect_html)    { read_sample_file 'sample_redirect.html' }
    let(:success_response) { Response.from_xml success_xml }
    let(:failure_response) { Response.from_xml failure_xml }

    describe '#success?' do
      it('returns true with success xml')  { expect(success_response).to     be_success }
      it('returns false with failure xml') { expect(failure_response).to_not be_success }
    end

    describe '#redirect_html' do
      it('returns the right html with success xml') { expect(success_response.redirect_html).to eq redirect_html }
      it('returns the right html with failure xml') { expect(failure_response.redirect_html).to eq '' }
    end

    describe '#status_code' do
      it('returns O20 with success xml') { expect(success_response.status_code).to eq 'O20' }
      it('returns O30 with failure xml') { expect(failure_response.status_code).to eq 'O30' }
    end

    describe '#reason_code' do
      it('returns O2010 with success xml') { expect(success_response.reason_code).to eq 'O2010' }
      it('returns O3050 with failure xml') { expect(failure_response.reason_code).to eq 'O3050' }
    end
  end
end
