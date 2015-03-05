#!/usr/bin/env ruby

require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 5000, :AccessLog => [], :Logger => WEBrick::Log::new("/dev/null", 7))
server.mount "/", WEBrick::HTTPServlet::FileHandler, './'
trap('INT') { server.stop }
server.start
