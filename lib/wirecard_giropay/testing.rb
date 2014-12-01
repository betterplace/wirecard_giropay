module WirecardGiropay
  class Testing
    def self.read_sample_file(file)
      File.read File.expand_path('../../../spec/support/' + file, __FILE__)
    end

    def self.sample_notification_success_xml
      read_sample_file 'sample_notification_success.xml'
    end
  end
end
