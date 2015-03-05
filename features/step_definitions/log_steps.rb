Given(/^I have a log file "([^"]*)" with the following$/) do |file_name, file_contents|
  File.delete("logs/#{file_name}") if File.exists?("logs/#{file_name}")
  File.open("logs/#{file_name}", 'w') {|f| f.puts(file_contents)}
end

Given(/^I have a log checker for "([^"]*)" and "([^"]*)"$/) do |file_name, search_list|
  @interim = 1
  @log_service = Log.new({ "log_file"=>"logs/#{file_name}", "entries"=>search_list.split(','), "interim" => @interim, "duration"=> 3 })
end

When(/^I test the log$/) do
  @actual_result = @log_service.test?
end

When(/^log file "([^"]*)" adds the following$/) do |file_name, new_file_contents|
  File.open(file_name, 'a') {|f| f.puts(new_file_contents)}
end

Then(/^the log checker found (\d+) entries$/) do |expected_found_entries_count|
  expect(@log_service.found_entries.count).to eq(expected_found_entries_count.to_i)
end

Then(/^the last noted entry contains "([^"]*)"$/) do |expected_entry|
  actual_entries = @log_service.found_entries
  if expected_entry.strip.length == 0
    expect(actual_entries.count).to eq(0)
  else
    actual_entries.last do |entry|
      expect(entry).to include(expected_entry)
    end
  end
end
