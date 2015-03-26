require 'webrick'

Before('@telnet') do
  fork { `ruby bin/telnet_server.rb 2>/dev/null` }
  sleep 1
end

After('@telnet') do
  begin
    pid = `netstat -anp|grep 5000|grep 0.0.0.0`.split[-1].split('/')[0].to_i
    Process.kill('INT', pid)
  rescue Errno::EPERM                     # changed uid
    puts "No permission to query #{pid}!"
  rescue Errno::ESRCH
    puts "#{pid} is NOT running.";      # or zombied
  rescue
    puts "Unable to determine status for #{pid}: #{$ERROR_INFO}"
  end
end

AfterStep('@pause') do
  print "Press Return to continue\n"
  STDIN.getc
end
