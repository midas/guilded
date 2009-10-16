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
      # end of the page with the dependencies specified for the Guilded components used.
      #
      # To explicitly include the jQuery or MooTools libraries you can use :jquery and/or :mootools
      # respectively.  If a component that uses either jQuery or MooTools is used on a page, there is
      # no need to explicitly include the library, as it will be resolved as a dependency and only 
      # included once.
      #
      def g_javascript_include_tag( *sources )
        g = Guilded::Guilder.instance
        defaults = nil
        if sources.include?( :defaults )
          defaults = ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES
          sources.delete( :defaults )
        end
        if sources.include?( :jquery )
          sources.insert( 0, g.jquery_js ) unless sources.include?( g.jquery_js )
          sources.delete( :jquery )
        end
        if sources.include?( :mootools )
          unless sources.include?( g.mootools_js )
            insert_at = 0
            insert_at = 1 if( sources.include?( g.jquery_js ) )
            sources.insert( insert_at, g.mootools_js )
          end
          sources.delete( :mootools )
        end
        if defaults
          g.add_js_sources( *(sources << defaults) )
        else
          g.add_js_sources( *sources )
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

      # Returns the name of the browser that is making this request.  For example 'ie'.  When using 
      # the browser detector in the contoller you may put a :g_browser_detector variabe in the session if 
      # you wish to keep the BrowserDetector from being instantiated more than once per request.
      #
      def g_browser_name
        @g_browser_detector = session[:g_browser_detector] if respond_to?( :session )
        @g_browser_detector ||= Guilded::BrowserDetector.new( request.env['HTTP_USER_AGENT'] )
        @g_browser_detector.browser_name
      end

      # Returns the version of the browser that is making this request.  For example '7'.  When using 
      # the browser detector in the contoller you may put a :g_browser_detector variabe in the session if 
      # you wish to keep the BrowserDetector from being instantiated more than once per request.
      #
      def g_browser_version
        @g_browser_detector = session[:g_browser_detector] if respond_to?( :session )
        @g_browser_detector ||= Guilded::BrowserDetector.new( request.env['HTTP_USER_AGENT'] )
        @g_browser_detector.browser_version
      end

      # Returns the browser name concatenated with the browser version.  for example, 'ie7'.  When using 
      # the browser detector in the contoller you may put a :g_browser_detector variabe in the session if 
      # you wish to keep the BrowserDetector from being instantiated more than once per request.
      #
      def g_browser_full_name
        @g_browser_detector = session[:g_browser_detector] if respond_to?( :session )
        @g_browser_detector ||= Guilded::BrowserDetector.new( request.env['HTTP_USER_AGENT'] )
        @g_browser_detector.browser_full_name
      end

      # Returns true if the browser matches the options ent in, otherwise returns false.  When using 
      # the browser detector in the contoller you may put a :g_browser_detector variabe in the session if 
      # you wish to keep the BrowserDetector from being instantiated more than once per request.
      #
      # === Options
      # * +:name+ - The name of the browser.  For example 'ie'.
      # * +:version+ - The version of the browser.  For example '7'.
      #
      def g_browser_is?( options={} )
        @g_browser_detector = session[:g_browser_detector] if respond_to?( :session )
        @g_browser_detector ||= Guilded::BrowserDetector.new( request.env['HTTP_USER_AGENT'] )
        @g_browser_detector.browser_is?( options )
      end

    end
  end
end