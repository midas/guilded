module Guilded
  module Rails
    module ViewHelpers

      # Generates the initGuildedElements function and includes a call to each GUIlded
      # element(s) Init method.
      #
      # Must be called once per rendered page.  You can include it just before the closing body 
      # tag of your application layout.  If no Guilded elements were called in the template, the 
      # call to g_apply_behavior will not output anything.
      #
      def g_apply_behavior        
        Guilded::Guilder.instance.generate_javascript_init
      end
      
      # Generates the JavaScript include(s) for each Guilded element that is used.
      #
      # Must be called once per rendered page.  You can include it just before the closing body 
      # tag of your application layout.  If no Guilded elements were called in the template, the 
      # call to g_apply_includes will not output anything.
      #
      def g_apply_includes
        g = Guilded::Guilder.instance
        g.generate_asset_lists

        # JavaScript
        if g.production? && g.use_remote_jquery
          js_groups = g.combined_js_srcs.partition { |src| src == g.jquery_js }
          output = javascript_include_tag( g.jquery_remote_url )
          output << javascript_include_tag( js_groups[1], :cache => "cache/#{g.js_cache_name}" ) unless js_groups[1].nil?
        else
          output = javascript_include_tag( g.combined_js_srcs, :cache => "cache/#{g.js_cache_name}" )
        end
        output
      end
      
      def g_apply_style
        "<!-- guilded.styles -->"
      end
      
      # Injects the CSS into the header.  Must be called once per rendered page and within a scope that allows access 
      # to the output buffer of the tempalte system being used.
      #
      def g_inject_styles
        g = Guilded::Guilder.instance
        self.output_buffer.sub!( /<!-- guilded.styles -->/, stylesheet_link_tag( g.combined_css_srcs, :cache => "cache/#{g.css_cache_name}" ) )
      end

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

      # Replaces the Rails stylesheet_link_tag helper if you wnat Guilded to manage CSS for you.  
      # Although the syntax is exactly the same, the method works a little differently.
      # 
      # This helper adds the stylesheet(s) to a collection to be renderred out together 
      # with all the guilded componenets stylesheets.  This allows the stylesheets passed 
      # to this method to be cached with the guilded stylesheests into a single reusable file.
      # 
      # The helper will ensure that these stylesheets are included after Guilded's reset
      # stylesheet and before guilded's component's stylesheets so that they can override any 
      # resets, etc and not override any guilded components styles.
      
      # *options*
      # :position The place to position the css. pre for before the component's css or post for after. 
      #    Defaults to post.
      #
      def g_stylesheet_link_tag( *sources )
        options = sources.extract_options! || {}
        options[:position] ||= :post
        sources.each { |src| Guilded::Guilder.instance.add_css_source( src, options[:position] ) }
        ''
      end
      
      # Outputs a conditional ie stylesheet link tag
      #
      def g_ie_stylesheet_link_tag( *args )
        options = {:version => 6}
        options.merge!( args.extract_options! )
        output = "<!--[if lte IE #{options[:version]}]>\n  #{stylesheet_link_tag( args )}\n<![endif]-->"
      end

      def g_skin_tag( source, skin='default' )
        path = "#{RAILS_ROOT}/public/stylesheets/#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}/#{skin}.css"
        if File.exists?( path )
          stylesheet_link_tag( "/stylesheets/#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}/#{skin}.css" )
        else
          ""
        end
      end
      
    end
  end
end