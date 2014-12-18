require_relative 'wordpress'
require_relative 'http'

#
# Basic CLI program container
#
class Program
  
  # Init the program
  def initialize
    puts "WordpressScan 0.1 - Nicolás Daniel Palumbo <n@xinax.net>"
    target = self.params()
    self.help() if target.nil?
    
    scanner = Wordpress.new(HttpHelper.new(target))
    scanner.scan()
    
    puts "\nScan finished. Bye!"
  end
  
  # Command line parameters
  def params
    ARGV[0].dup if ARGV.length > 0
  end
  
  # shows help
  def help
    puts "Usage: ./main <host>"
    abort()
  end
  
end