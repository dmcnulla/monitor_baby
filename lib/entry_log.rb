# EntryLog class is an attempt to store log entries found in an array in memory
class EntryLog
  attr_reader :name, :entries

  def initialize(name, entries = [])
    @name = name
    @entries = []
    add_entries(entries)
  end

  def add_entry(entry)
    debug "new entry #{entry}"
    @entries.push(entry)
  end

  def add_entries(entries)
    debug "adding entries: #{entries}"
    entries.each { |entry| add_entry(entry) }
  end

  def size
    @entries.count
  end

  def last
    @entries.last
  end

  def first
    @entries.first
  end

  def count
    size
  end

  def debug(message)
    puts message if ENV['DEBUG'] == 'true'
  end
end
