class GuildedAssetsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file "guilded.js", "public/javascripts/guilded.js"
      m.file "guilded.min.js", "public/javascripts/guilded.min.js"
      m.directory "public/javascripts/jquery"
      m.file "jquery-1.2.6.js", "public/javascripts/jquery/jquery-1.2.6.js"
      m.file "jquery-1.2.6.min.js", "public/javascripts/jquery/jquery-1.2.6.min.js"
      m.file "jquery-1.3.2.js", "public/javascripts/jquery/jquery-1.3.2.js"
      m.file "jquery-1.3.2.min.js", "public/javascripts/jquery/jquery-1.3.2.min.js"
      m.file "jquery-url.js", "public/javascripts/jquery/jquery-url.js"
      m.file "jquery-url.min.js", "public/javascripts/jquery/jquery-url.min.js"
      m.directory "public/javascripts/mootools"
      m.file "mootools-1.2.3.js", "public/javascripts/mootools/mootools-1.2.3.js"
      m.file "mootools-1.2.3.min.js", "public/javascripts/mootools/mootools-1.2.3.min.js"
      m.file "reset-min.css", "public/stylesheets/reset-min.css"
    end
  end
end