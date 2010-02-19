$LOAD_PATH.unshift( File.dirname(__FILE__) )
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), '..', 'lib' ) )
require 'rubygems'
require 'guilded'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  
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
