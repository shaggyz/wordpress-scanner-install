#
# Wordpress scanner
#
class Wordpress
  
  def initialize(http)
    #host.prepend('http://') if host['http://'].nil?
    @http = http
    @target = http.host
  end
  
  # Start all scanners 
  def scan
    puts "About to scan: #{@target}: \n\n"
    @index = @http.get_page("/", "index.html", true)
    self.get_version()
    self.get_uploads()
    self.get_plugins()
    self.get_robots()
  end

  # Tries to get the wordpress version
  def get_version
    @index[/generator"\s+content="(.+)"/]
    puts "[+] Version detected: " << $1 unless $1.nil?
  end
  
  # Tries to get the robots.txt file
  def get_robots
    res = @http.get_response("/robots.txt")
    if res.is_a?(Net::HTTPSuccess)
      robots = res.body 
      puts "[+] Robots.txt found: "
      puts "\t ---- begin robots.txt contents ----"
      puts robots
      puts "\t ---- end robots.txt contents ----"
    else
      puts "[-] No robots.txt file"
    end
  end

  # Tries to get the uploads folder index
  def get_uploads
    res = @http.get_response("/wp-content/uploads/")
    if res.is_a?(Net::HTTPSuccess)
      uploads = @http.get_page("/wp-content/uploads/", "uploads.html")
      upload_years = []
      uploads.scan(/href="([a-zA-Z\d\.\/]+)"/) { |link|
        upload_years.push(link)
      }
      if(upload_years.length > 0)
        puts "[+] Found #{upload_years.length} element indexed in public uploads:"
        puts "\t " << upload_years.join(", ")
      end
    else
      puts "[-] No uploads index available"
    end
  end
  

  # Tries to get the plugins folder index
  def get_plugins
    res = @http.get_response("/wp-includes/")
    if res.is_a?(Net::HTTPSuccess)
      uploads = @http.get_page("/wp-includes/", "wp-includes.html")
      upload_years = []
      uploads.scan(/href="([a-zA-Z\d\.\/]+)"/) { |link|
        upload_years.push(link)
      }
      if(upload_years.length > 0)
        puts "[+] Found #{upload_years.length} element indexed in wp-includes:"
        puts "\t " << upload_years.join(", ")
      end
    else
      puts "[-] No wp-includes index available"
    end
  end
  
  # Shows errors
  def error(message, abort_on_error=false)
    puts message
    abort() if abort_on_error
  end
  
end