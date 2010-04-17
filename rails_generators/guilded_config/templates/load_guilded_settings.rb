# While Guilded is framework agnostic, this config file is Rails specific.  You can create your own config file based
# on this one in order to work in different environments.
#
GUILDED_CONFIG = {
  :js_path => "#{Rails.root}/public/javascripts/",
  :js_folder => "", # from the js_path
  :jquery_js => "jquery/jquery-1.3.2.min.js", # from the js_path
  :mootools_js => "mootools/mootools-1.2.3.min.js", # from the js_path
  :css_path => "#{Rails.root}/public/stylesheets/",
  :css_folder => "guilded/", # from the css_path
  :reset_css => "reset-min.css", # from the css_path
  :environment => Rails.env
}