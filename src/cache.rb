#
# Cache file-manager
#
class FileCache
  
  # sets the base identifier
  def initialize(identifier)
    @basepath = './cache/' << identifier
    self.check_directory()
  end
  
  # Saves the host cache
  def set_cache(content, filename)
    path = self.full_path(filename)
    File.open(path, 'w') do |f|
      f.puts content
    end
    content
  end
  
  # Loads the hosts cache
  def get_cache(filename)
    begin
      File.read(self.full_path(filename))
    rescue Exception 
      nil
    end
  end
  
  # boolean that indicates if cache holds content
  def has_content?(file)
    cache = self.get_cache(file)
    return true unless cache.nil?
  end
  
  # checks if cache directory exists otherwise tries to create it
  protected
  def check_directory()
    if !File.directory?(self.full_path())
      Dir.mkdir(self.full_path())
    end
  end
  
  # returns the full path of given filename
  def full_path(filename="")
    path = @basepath.dup # byVal 
    if filename.length > 0
      path << "/" << filename
    end
    path
  end  
  
end