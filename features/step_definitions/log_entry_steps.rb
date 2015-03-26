Given(/^I have an entry logger "([^"]*)"$/) do |name|
  @entry_logger = EntryLog.new(name)
  @count = 0
end

When(/^I add a new entry "([^"]*)"$/) do |entry|
  @entry_logger.add_entry(entry)
end

When(/^I add a new entries$/) do |entries|
  data = []
  entries.rows.each { |row| data.push row[0] }
  @entry_logger.add_entries(data)
end

Then(/^the entry logger is called "(.*?)"$/) do |expected_name|
  expect(@entry_logger.name).to eq(expected_name)
end

Then(/^the size grows$/) do
  new_count = @entry_logger.count
  expect(new_count).to be > @count
end

Then(/^the (first|last) entry contains "([^"]*)"$/) do |which, sample|
  if which == 'first'
    expect(@entry_logger.first).to include(sample)
  else
    expect(@entry_logger.last).to include(sample)
  end
end
