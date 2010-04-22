# While Guilded is framework agnostic, this config file is Rails specific.  You can create your own config file based
# on this one in order to work in different environments.
#
GUILDED_CONFIG = {
  :app_root => Rails.root.to_s,
  :js_path => "#{Rails.root}/public/javascripts/",
  :js_folder => "", # from the js_path
  :jquery_js => "jquery/jquery-1.3.2.min.js", # from the js_path
  :use_remote_jquery => true,
  :jquery_remote_url => "http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js",
  :mootools_js => "mootools/mootools-1.2.3.min.js", # from the js_path
  :css_path => "#{Rails.root}/public/stylesheets/",
  :css_folder => "guilded/", # from the css_path
  :reset_css => "reset-min.css", # from the css_path
  :environment => Rails.env
}