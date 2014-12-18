require_relative 'cache'
require('net/http')

#
# Simple HTTP wrapper
#
class HttpHelper
  
  attr_accessor :host
  
  # propagates base host
  def initialize(host)
    @host = host
  end
  
  # Makes a http request 
  def get_response(url)
    Net::HTTP.get_response(@host, url)
  end  
  
  # Gets the wordpress home page
  def get_page(url, filename, abort_on_error=false)
    begin
      cache = FileCache.new(@host)
      if cache.has_content?(filename)
        puts "[+] Loading page from cache: #{filename}"
        index = cache.get_cache(filename)
      else
        puts "[+] Retrieving page... #{filename}"
        index = Net::HTTP.get(@host, url)
        cache.set_cache(index, filename)  
      end
      index
    rescue SocketError => e
      self.error("Connection error [#{e.message}], is host alive?", abort_on_error)
    rescue Exception => e
      self.error("Unknown error: [#{e.message}]", abort_on_error)
    end
  end
  
  # Shows errors
  def error(message, abort_on_error=false)
    puts message
    abort() if abort_on_error
  end
  
end