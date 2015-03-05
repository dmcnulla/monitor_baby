require 'net/ping'
require_relative 'checker.rb'

module MonitorBaby
  # Checker for pinging a server to see if it's reachable.
  class Ping < Checker
    DEFAULT_HOST = 'localhost'
    DEFAULT_PORT = 7
    DEFAULT_NAME = 'ping_checker'
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
      Net::Ping::TCP.econnrefused = true
      @ping_obj = Net::Ping::TCP.new(@host, @port, 1)
    end

    def type
      "Ping: host = #{@host}, port = #{@port}"
    end

    def test?
      result = @ping_obj.ping?
      log result
      result
    end
  end
end
