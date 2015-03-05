require 'yaml'

module ServiceMonitor
  # Configure class
  class Configure
    attr_accessor :config, :obj

    def initialize(file)
      @config = YAML.load_file(file)
      @obj = create(@config)
    end

    def create(data)
      case data['type']
      when 'ping'        then Ping.new(data)
      when 'telnet'      then Telnet.new(data)
      when 'web'         then Web.new(data)
      when 'webresponse' then WebResponse.new(data)
      when 'log'         then Log.new(data)
      else               fail "Unknown type: #{data['type']}"
      end
    end
  end
end
