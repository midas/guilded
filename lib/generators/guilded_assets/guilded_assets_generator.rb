require 'rails/generators'

class GuildedAssetsGenerator < Rails::Generators::Base
  def self.source_root
    File.join( File.dirname(__FILE__), 'templates' )
  end
  
  def install_config
    copy_file "guilded.js", "public/javascripts/guilded.js"
    copy_file "guilded.min.js", "public/javascripts/guilded.min.js"
    copy_file "jquery-1.2.6.js", "public/javascripts/jquery/jquery-1.2.6.js"
    copy_file "jquery-1.2.6.min.js", "public/javascripts/jquery/jquery-1.2.6.min.js"
    copy_file "jquery-1.3.2.js", "public/javascripts/jquery/jquery-1.3.2.js"
    copy_file "jquery-1.3.2.min.js", "public/javascripts/jquery/jquery-1.3.2.min.js"
    copy_file "jquery-url.js", "public/javascripts/jquery/jquery-url.js"
    copy_file "jquery-url.min.js", "public/javascripts/jquery/jquery-url.min.js"
    copy_file "mootools-1.2.3.js", "public/javascripts/mootools/mootools-1.2.3.js"
    copy_file "mootools-1.2.3.min.js", "public/javascripts/mootools/mootools-1.2.3.min.js"
    copy_file "reset-min.css", "public/stylesheets/reset-min.css"
  end
end