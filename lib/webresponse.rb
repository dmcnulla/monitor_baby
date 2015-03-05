require 'net/http'
require 'uri'

module ServiceMonitor
  # WebResponse checkers validates a return from a rest call such as healthcheck
  class WebResponse < Web
    DEFAULT_URL = 'http://localhost:80/'
    DEFAULT_NAME = 'webresponse_checker'
    DEFAULT_SCHEDULE = 60 # 60 seconds
    DEFAULT_DATA = {
      'url' => DEFAULT_URL,
      'body' => 'true',
      'name' => DEFAULT_NAME,
      'schedule' => DEFAULT_SCHEDULE
    }

    def initialize(details = DEFAULT_DATA)
      @details = DEFAULT_DATA.merge(details)
      @schedule = @details['schedule']
      @name = @details['name']
      @last_time = first_time

      uri = URI(@details['url'])
      @http = Net::HTTP.new(uri.host, uri.port)
      @page = uri.request_uri
      @expected_body = Regexp.new(@details['body'])
    end

    def type
      "WebResponse: url = #{@url}, expected_response = #{expected_body}"
    end

    def test?
      request_body = @http.request(Net::HTTP::Get.new(@page)).body.strip
      if request_body.nil?
        return false
      elsif request_body.match(Regexp.new @expected_body).nil?
        return false
      else
        return true
      end
    end
  end
end
