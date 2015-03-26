require 'socket'
require 'timeout'

module MonitorBaby
  # Telnet checker verifies a port is open on a host
  class Telnet < Checker
    DEFAULT_HOST = 'localhost'
    DEFAULT_PORT = 80
    DEFAULT_NAME = 'telnet_checker'
    DEFAULT_SCHEDULE = 60 # 60 seconds
    DEFAULT_DATA = {
      'host' => DEFAULT_HOST,
      'port' => DEFAULT_PORT,
      'name' => DEFAULT_NAME,
      'schedule' => DEFAULT_SCHEDULE
    }

    def initialize(details = DEFAULT_DATA)
      @details = DEFAULT_DATA.merge(details)
      @schedule = @details['schedule']
      @name = @details['name']
      @last_time = first_time

      @host = @details['host']
      @port = @details['port']
      @checker_type = type
    end

    def type
      "Telnet: host = #{@host}, port = #{@port}"
    end

    def test?
      Timeout.timeout(1) do
        begin
          s = TCPSocket.new(@host, @port)
          s.close
          true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          false
        end
      end
    rescue
      false
    end
  end
end
