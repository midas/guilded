require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'guilded'

class Test::Unit::TestCase
end

RAILS_ROOT = ''
GUILDED_CONFIG = {
  :js_path => "#{RAILS_ROOT}/public/javascripts/",
  :js_folder => "", # from the js_path
  :jquery_js => "jquery/jquery-1.3.2.min.js", # from the js_path
  :css_path => "#{RAILS_ROOT}/public/stylesheets/",
  :css_folder => "guilded/", # from the css_path
  :reset_css => "reset-min.css", # from the css_path
  :environment => 'development'
}

class Thing
end
class Owner
end
class Parent
end
class Lookup
end

class View
  attr_accessor :request
  
  def initialize
    @request = Request.new
  end
end
View.send( :include, Guilded::Rails::ViewHelpers )

class Request
  attr_accessor :env
  
  def initialize
    @env = { 'HTTP_USER_AGENT' => Guilded::BrowserDetector.user_agents[:firefox35] }
  end
end