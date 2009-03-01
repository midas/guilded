module Guilded
  module Rails
    module ViewHelpers
   
      # Generates the JavaScript includes for each Guilded element that is used.  Also
      # generates the initGuildedElements function and includes a call to each GUIlded
      # elements Init method.
      #
      # Must be called once per rendered page.  You can include it just before the closing body 
      # tag of your application layout.  If no Guilded elements were called in the template, the 
      # call to g_apply_behavior will not output anything.
      #
      def g_apply_behavior
        g = Guilded::Guilder.instance
        html = stylesheet_link_tag( g.combined_css_srcs, :cache => "cache/#{g.css_cache_name}" )
        html << javascript_include_tag( g.combined_js_srcs, :cache => "cache/#{g.js_cache_name}" )
        html << g.generate_javascript_init
      end
      
    end
  end
end