require_relative 'checker.rb'

module ServiceMonitor
  # Log class checks for logs
  class Log < ServiceMonitor::Checker
    DEFAULT_LOG_FILE = 'logs/test.log'
    DEFAULT_ENTRIES = ['ERROR']
    DEFAULT_NAME = 'log_checker'
    DEFAULT_INTERIM = 60 # 60 seconds
    DEFAULT_DURATION = 30 # 30 seconds
    DEFAULT_DATA = {
      'log_file' => DEFAULT_LOG_FILE,
      'entries' => DEFAULT_ENTRIES,
      'name' => DEFAULT_NAME
    }

    def initialize(details = DEFAULT_DATA)
      @details = DEFAULT_DATA.merge(details)
      @name = @details['name']
      @log_file = @details['log_file']
      @entries = @details['entries']
      @last_line_checked = 0
      @found_entries = []
    end

    def type
      ({ 'Log' => { 'file' => @log_file, 'entries' => @entries } }).to_json
    end

    def test?
      lines = get_log_lines(@last_line_checked)
      # TODO: what happens if the log is cycled?
      @last_line_checked += lines.count
      found_lines_with_entries = test_lines(lines)
      store_found_entries(found_lines_with_entries)
      found_lines_with_entries.length == 0
    end

    def test_lines(lines)
      found_entries = []
      lines.each do |line|
        search_results = test_line(line)
        found_entries.push(line => search_results) if search_results.length > 0
      end
      found_entries
    end

    def test_line(line)
      found_entries = []
      @entries.each do |entry|
        found_entries.push(entry) if line.include?(entry)
      end
      found_entries
    end

    def found_entries
      @found_entries[0]
    end

    def get_log_lines(start_line)
      lines = []
      File.open(@log_file, 'r')do |f|
        lines = f.readlines
        f.close
      end
      lines[start_line..-1]
    end

    def store_found_entries(new_entries)
      @found_entries.push new_entries
    end
  end
end
