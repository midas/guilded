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
        self.output_buffer.sub!( /<!-- guilded.styles -->/, stylesheet_link_tag( Guilded::Guilder.instance.combined_css_srcs, :cache => "cache/#{Guilded::Guilder.instance.css_cache_name}" ) )
        html = javascript_include_tag( Guilded::Guilder.instance.combined_js_srcs, :cache => "cache/#{Guilded::Guilder.instance.js_cache_name}" )
        html << Guilded::Guilder.instance.generate_javascript_init
        html
      end
      
      def g_apply_style
        "<!-- guilded.styles -->"
      end
      
      # Generates the base javascript includes, if they have not alreay been included.
      #
      # def g_includes
      #         return "" if @base_included
      #         @base_included = true
      #         javascript_include_tag( 'jquery/jquery-1.2.6.min.js' ) +
      #           "<script type=\"text/javascript\">$j = jQuery.noConflict(); g={};</script>"
      #       end

      # Creates a javascript include tag for a Guilded specific file.  The only difference
      # being that it adds the file to a sources array to be concatenated and included at the 
      # end of the page.
      #
      # Utilizes the js_include_tag helper from Rails.
      #
      def g_javascript_include_tag( *sources )
        g = Guilded::Guilder.instance
        defaults = nil
        if sources.include?( :defaults )
          defaults = ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES
          sources.delete( :defaults )
        end
        if defaults
          g.combined_js_srcs.push( *(sources << defaults) )
        else
          g.combined_js_srcs.push( *sources )
        end
        ''
      end

      # Written to replace the Rails stylesheet_link_tag helper.  Although the syntax
      # is exactly the same, the method works a little differently.
      # 
      # This helper adds the stylesheet(s) to a collection to be renderred out together 
      # with all the guilded componenets stylesheets.  This allows the stylesheets passed 
      # to this method to be cached with the guilded stylesheests into a single reusable file.
      # 
      # The helper will ensure that these stylesheets are included after Guilded's reset
      # stylesheet and before guilded's component's stylesheets so that they can override any 
      # resets, etc and not override any guilded components styles.
      #
      def g_stylesheet_link_tag( *sources )
        options = sources.extract_options!
        g = Guilded::Guilder.instance
        
        if options[:ensure_primary]
          g.inject_css( *sources )
        else
          g.combined_css_srcs.push( *sources )
        end
        ''
      end

      def g_skin_tag( source, skin='default' )
        path = "#{RAILS_ROOT}/public/stylesheets/#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}/#{skin}.css"
        if File.exists?( path )
          stylesheet_link_tag( "/stylesheets/#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}/#{skin}.css" )
        else
          ""
        end      
      end
      
      # Returns the name of the browser that is making this request.  For example 'ie'.
      #
      def g_browser_name
        Guilded::BrowserDetector.browser_name( request )
      end
      
      # Returns the version of the browser that is making this request.  For example '7'.
      #
      def g_browser_version
        Guilded::BrowserDetector.browser_version( request )
      end
      
      # Returns the browser name concatenated with the browser version.  for example, 'ie7'.
      #
      def g_browser_full_name
        Guilded::BrowserDetector.browser_full_name( request )
      end
      
      # Returns true if the browser matches the options ent in, otherwise returns false.
      #
      # === Options
      # * +:name+ - The name of the browser.  For example 'ie'.
      # * +:version+ - The version of the browser.  For example '7'.
      #
      def g_browser_is?( options={} )
        Guilded::BrowserDetector.browser_is?( request, options )
      end
      
    end
  end
end