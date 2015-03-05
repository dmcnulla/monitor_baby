require 'net/http'
require 'uri'

module MonitorBaby
  class Web < Checker
    DEFAULT_URL = 'http://localhost:80/'
    DEFAULT_NAME = 'web_checker'
    DEFAULT_SCHEDULE = 60 # 60 seconds
    DEFAULT_DATA = {
      'url' => DEFAULT_URL,
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
      @schedule = @details['schedule']
      @page = uri.request_uri
    end

    def type
      "Web: url = #{@url}"
    end

    def test?
      begin
        response = @http.request(Net::HTTP::Get.new(@page))
        return response.is_a?(Net::HTTPOK)
      rescue
        false
      end
    end
  end
end
