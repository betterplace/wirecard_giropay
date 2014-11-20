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

    describe '#params' do
      context 'for a success response' do
        let(:params) { success_response.params }

        it('params[:success] returns true')                 { expect(params[:success]).to eq true }
        it('params[:redirect_html] returns the right html') { expect(params[:redirect_html]).to eq redirect_html }
        it('params[:status_code] returns O20')              { expect(params[:status_code]).to eq 'O20' }
        it('params[:reason_code] returns O2010')            { expect(params[:reason_code]).to eq 'O2010' }
        it('params[:guwid] returns the correct guwid')      { expect(params[:guwid]).to eq 'F815887120947517965048' }
      end

      context 'for a failure response' do
        let(:params) { failure_response.params }

        it('params[:success] returns false')            { expect(params[:success]).to eq false }
        it('params[:redirect_html] returns ""')         { expect(params[:redirect_html]).to eq '' }
        it('params[:status_code] returns O30')          { expect(params[:status_code]).to eq 'O30' }
        it('params[:reason_code] returns O3050')        { expect(params[:reason_code]).to eq 'O3050' }
        it('params[:guwid] returns the correct guwid')  { expect(params[:guwid]).to eq 'F815207120947498218406' }
      end
    end

  end
end
