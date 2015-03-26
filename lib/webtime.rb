require 'net/http'
require 'uri'
require_relative 'checker.rb'
require_relative 'web.rb'

module MonitorBaby
  # WebResponse checkers validates a return from a rest call such as healthcheck
  class WebTime < Web
    DEFAULT_URL = 'http://localhost:80/'
    DEFAULT_NAME = 'webtime_checker'
    DEFAULT_SCHEDULE = 60 # 60 seconds
    DEFAULT_TIME = 1000
    DEFAULT_RESPONSE_CODE = 200
    DEFAULT_DATA = {
      'url' => DEFAULT_URL,
      'time_ms' => DEFAULT_TIME,
      'name' => DEFAULT_NAME,
      'response_code' => DEFAULT_RESPONSE_CODE,
      'schedule' => DEFAULT_SCHEDULE,
      'test' => false
    }

    def initialize(details = DEFAULT_DATA)
      @details = DEFAULT_DATA.merge(details)
      @schedule = @details['schedule']
      @name = @details['name']
      @last_time = first_time

      uri = URI(@details['url'])
      @http = Net::HTTP.new(uri.host, uri.port)
      @page = uri.request_uri
      @expected_time = @details['time_ms']
      @expected_response_code = @details['response_code']
    end

    def type
      "WebTime: url = #{@url}, expected_time = #{expected_time}"
    end

    def test?
      start_time = Time.now.strftime('%L').to_i
      response = @http.request(Net::HTTP::Get.new(@page))
      debug_slow
      finish_time = Time.now.strftime('%L').to_i
      actual_time = finish_time - start_time
      (actual_time <= @expected_time) && (response.code == "#{@expected_response_code}")
    end

    def debug_slow
      sleep (50.0/1000.0) if @test = true
    end
  end
end
