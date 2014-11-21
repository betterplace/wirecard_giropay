module WirecardGiropay
  class Request
    TEMPLATE_PATH = File.expand_path('../../../templates/request.xml', __FILE__)

    class InvalidParamsError < StandardError; end

    PARAMS = %i(business_case_signature transaction_id first_name last_name account_number bank_code
                country amount_in_cents currency usage success_redirect_url failure_redirect_url redirect_window_name
                notification_url alternate_notification_url order_data
               )

    def initialize(given_params = {})
      @given_params = given_params
      PARAMS.each do |param|
        raise InvalidParamsError.new("Following parameters are required '#{PARAMS}'.") unless given_params.has_key?(param)
      end
      order_data = given_params[:order_data]
      raise InvalidParamsError.new("Parameter 'order_data' must be a Hash.") if order_data and !order_data.is_a?(Hash)
    end

    def to_xml
      xml_template = File.read TEMPLATE_PATH
      xml_template.gsub /%\{\w+\}/, replace_params
    end

    def run
      Response.from_xml Typhoeus.post(WirecardGiropay.gateway_url, body: to_xml).body
    end

    private

    def replace_params
      rep_params = {}
      @given_params.each { |key, value| rep_params["%{#{key}}"] = value }
      rep_params['%{order_data}'] = order_data_xml
      rep_params['%{transaction_mode}'] = transaction_mode
      rep_params
    end

    def order_data_xml
      return '' unless @given_params[:order_data]
      orders = '<ORDER_DATA>'
      @given_params[:order_data].each { |key, parameter| orders << "<Parameter name=\"#{key}\">#{parameter}</Parameter>" }
      orders << '</ORDER_DATA>'
    end

    def transaction_mode
      WirecardGiropay.sandboxed? ? 'demo' : 'live'
    end
  end
end
