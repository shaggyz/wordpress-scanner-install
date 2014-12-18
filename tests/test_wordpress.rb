require 'test/unit'
require_relative '../src/wordpress'
require_relative '../src/http'

class TestWordpress < Test::Unit::TestCase
  
  def setup
    @program = Wordpress.new(HttpHelper.new('wordpress.org'))
  end
  
  def test_wordpress
    assert(@program.is_a?(Wordpress), 'Bad instance')
  end
  
end