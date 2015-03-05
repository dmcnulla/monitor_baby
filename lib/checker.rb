TIME_FORMAT = '%Y%m%d %H%M%S'
MAX_LOGS = 600

module ServiceMonitor
  # Checker is the base class for all checker types including ping,
  # telnet, log, web, webresponse.
  class Checker
    attr_reader :last_time, :interim, :duration, :logs, :checker_type

    def type
      'None'
    end

    def test?
      nil
    end

    def notify(message)
      message
    end

    def run_status
      puts "suspended #{@suspended}"
      ! @suspended
    end

    def log(result)
      f = File.open(log_file_name, 'a')
      f.puts("#{Time.now} \"(#{type})\" #{result}")
      f.close
    end

    def print_logs
      File.read(log_file_name)
    end

    def update_time
      @last_time = Time.now
    end

    def log_file_name
      "logs/#{@name}_#{Time.now.strftime('%Y%m%d')}.log"
    end

    def first_time
      Time.new(2000, 01, 01)
    end

    def suspend
      @suspended = true
    end

    def debug(message)
      puts message if ENV['DEBUG'] == 'true'
    end
  end
end
