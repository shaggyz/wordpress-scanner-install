#!/usr/bin/env ruby

# Add local files to include path
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Static entry point
if __FILE__ == $0
  require 'program'
  Program.new
end