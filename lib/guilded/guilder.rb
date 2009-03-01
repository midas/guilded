require 'digest'
require 'singleton'

module Guilded
  class Guilder
    include Singleton
    
    # The folder name for guilded JavaScript files.  Must include trailing '/'.
    GUILDED_JS_FOLDER = "guilded/"
    # The folder name for guilded css files.  Must include trailing '/'.
    GUILDED_CSS_FOLDER = "guilded/"
    GUILDED_NS = "guilded."
  
    attr_reader :combined_js_srcs, :combined_css_srcs
    
    def initialize( options={} ) #:nodoc:
      @env = options[:env].to_sym if options[:env]
      @env ||= :production
      @g_elements = Hash.new #unless @g_elements
      @combined_js_srcs = Array.new #if @combined_js_srcs.nil?
      @combined_css_srcs = Array.new #if @combined_css_srcs.nil?
    
      # Make sure that the css reset file is first so that other files can override the reset,
      # unless the user specified no reset to be included.
      init_sources
      # @combined_css_srcs << Guilded::Base::RESET_CSS unless options[:reset] == false
      #       @combined_js_srcs << Guilded::Base::GUILDED_JS << Guilded::Base::JQUERY_JS
      #TODO find a way to get the resolve js libs to work on these two so we get the non-min version in development
    end
  
    # Adds an element with its options to the @g_elements hash to be used later.
    #
    def add( element, options={}, libs=[], styles=[] )
      raise Guilded::Exceptions::IdMissing unless options.has_key?( :id )
      raise Guilded::Exceptions::DuplicateElementId( options[:id] ) if @g_elements.has_key?( options[:id] )
      @g_elements[ options[:id] ] = Guilded::ComponentDef.new( element, options, libs, styles )
    end
    
    # Clears out all but the reset CSS and the base JavaScripts
    #
    def reset!
      @combined_css_srcs.clear
      @combined_js_srcs.clear
      init_sources
    end

    # Generates the markup required to include all the assets necessary for the Guilded compoents in 
    # @g_elements collection.
    #
    def apply
      to_init = ""
      
      generate_asset_lists
      # @g_elements.each_value do |defi|
      #         #TODO get stylesheet (skin) stuff using rails caching
      #         combine_css_sources( defi.kind, defi.options[:skin], defi.styles ) unless defi.exclude_css?
      # 
      #         # Combine all JavaScript sources so that the caching option can be used on
      #         # the javascript_incldue_tag helper.
      #         combine_js_sources( defi.kind, defi.libs ) unless defi.exclude_js?
      #       end

      # # Add default styles
      #       Guilded::Base::COMMON_CSS.each do |style|
      #         @combined_css_srcs.push( style ) unless @combined_css_srcs.include?( style )
      #       end
      # 
      #       # Add default JavaScripts
      #       Guilded::Base::COMMON_JS.each do |script|
      #         @combined_js_srcs.push( script ) unless @combined_js_srcs.include?( script )
      #       end

      to_init << stylesheet_link_tag( @combined_css_srcs, :cache => "cache/#{generate_css_cache_name( @combined_css_srcs )}" )
      to_init << javascript_include_tag( @combined_js_srcs, :cache => "cache/#{generate_js_cache_name( @combined_js_srcs )}" )

      # to_init << "<script type=\"text/javascript\">"
      #       to_init << "var initGuildedElements = function(){"
      # 
      #       @g_elements.each_value do |guilded_def| 
      #         to_init << " g.#{guilded_def.kind.to_s.camelize( :lower )}Init( #{guilded_def.options.to_json} );" unless guilded_def.exclude_js?
      #       end
      # 
      #       to_init << "}; jQuery('document').ready( initGuildedElements );</script>"
      to_init << generate_javascript_init
    end
    
    def generate_javascript_init
      code = "<script type=\"text/javascript\">"
      code << "var initGuildedElements = function(){"
      @g_elements.each_value do |guilded_def| 
        to_init << "g.#{guilded_def.kind.to_s.camelize( :lower )}Init( #{guilded_def.options.to_json} );" unless guilded_def.exclude_js?
      end
      to_init << "};jQuery('document').ready( initGuildedElements );</script>"
    end
    
    def generate_js_cache_name( sources )      
      #return"#{controller.class.to_s.underscore}_#{controller.action_name}" if development?
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.js/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end
    
    def generate_css_cache_name( sources )
      #return "#{controller.class.to_s.underscore}_#{controller.action_name}" if development?
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.css/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end
    
  protected
    
    def init_sources
      @combined_css_srcs << Guilded::Base::RESET_CSS unless options[:reset] == false
      @combined_js_srcs << Guilded::Base::GUILDED_JS << Guilded::Base::JQUERY_JS
    end
    
    # Combines all JavaScript and CSS files into lists to include based on what Guilded components are on 
    # the current page.
    #
    def generate_asset_lists
      @g_elements.each_value do |defi|
        #TODO get stylesheet (skin) stuff using rails caching
        combine_css_sources( defi.kind, defi.options[:skin], defi.styles ) unless defi.exclude_css?

        # Combine all JavaScript sources so that the caching option can be used on
        # the javascript_incldue_tag helper.
        combine_js_sources( defi.kind, defi.libs ) unless defi.exclude_js?
      end
    end
    
    # Helper method that takes the libs and component specific js files and puts them
    # into one array so that the javascript_include_tag can correctly cache them.  Automatically
    # ignores files that have already been inlcuded.
    #
    # *parameters*
    # combined_src (required) An array of the combined sorces for the page being renderred.
    # component (required) The name of a guilded component.
    # libs An array of JavaScript libraries that this component depends on.  More than likely 
    #   a jQuery plugin, etc.
    #
    def combine_js_sources( component, libs=[] )  #:doc:
      resolve_js_libs( libs )
      
      comp_src = add_guilded_js_path( component )
      @combined_js_srcs.push( comp_src ) unless @combined_js_srcs.include?( comp_src )
    end
    
    # Helper method that adds the aditional JavaScript library icludes to the include set.
    # 
    # If running development mode, it will try to remove any .pack, .min, or.compressed
    # parts fo the name to try and get the debug version of the library.  If it cannot 
    # find the debug version of the file, it will just remain  what was initially provded.
    #
    def resolve_js_libs( libs )
      if development?
        # Try to use an unpacked or unminimized version
        libs.each do |lib|
          debug_lib = lib.gsub( /.pack/, '' ).gsub( /.min/, '' ).gsub( /.compressed/, '' )
          path = "#{RAILS_ROOT}/public/javascripts/#{debug_lib}"
          if File.exist?( path )
            @combined_js_srcs.push( debug_lib ) unless @combined_js_srcs.include?( debug_lib )
          else
            @combined_js_srcs.push( lib ) unless @combined_js_srcs.include?( lib )
          end
        end
      else
        libs.each do |lib|
          @combined_js_srcs.push( lib ) unless @combined_js_srcs.include?( lib )
        end
      end
    end
    
    # Helper method that takes an array of js sources and adds the correct guilded
    # path to them.  Returns an array with the new path resolved sources.
    #
    def map_guilded_js_paths( *sources )
      sources.map { |source| add_guilded_js_path( source ) }
    end
    
    # Adds the guilded JS path to the
    #
    def add_guilded_js_path( source )
      part = "#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}"
      ext = 'js'
      
      return "#{part}.#{ext}" if development?
 
      possibles = {
        "#{RAILS_ROOT}/public/javascripts/#{part}.pack.#{ext}" => "#{part}.pack.#{ext}",
        "#{RAILS_ROOT}/public/javascripts/#{part}.min.#{ext}" => "#{part}.min.#{ext}",
        "#{RAILS_ROOT}/public/javascripts/#{part}.compressed.#{ext}" => "#{part}.compressed.#{ext}",
        "#{RAILS_ROOT}/public/javascripts/#{part}.#{ext}" => "#{part}.#{ext}"
      }
      
      possibles.each do |full_path, part_path|
        return part_path if File.exists?( full_path )           
      end
    end
    
    def combine_css_sources( component, skin, styles=[] )  #:doc:
      # Get all of this components defined external styles
      styles.each do |style|
        @combined_css_srcs.push( style ) unless @combined_css_srcs.include?( style )
      end
      
      #Get the default or guilded skin styles for this component
      comp_src = add_guilded_css_path( component, skin )
      @combined_css_srcs.push( comp_src ) unless @combined_css_srcs.include?( comp_src ) || comp_src.empty?
      user_src = add_guilded_css_path( component, "user" )
      @combined_css_srcs.push( user_src ) unless @combined_css_srcs.include?( user_src ) || user_src.empty?
      skin_user_src = add_guilded_css_path( component, "#{skin || 'default'}_user" )
      @combined_css_srcs.push( skin_user_src ) unless @combined_css_srcs.include?( skin_user_src ) || skin_user_src.empty?
    end
    
    def add_guilded_css_path( source, skin )
      skin = 'default' if skin.nil? || skin.empty?
      part = "#{GUILDED_CSS_FOLDER}#{source.to_s}/#{skin}.css"
      path = "#{RAILS_ROOT}/public/stylesheets/#{part}"
      File.exists?( path ) ? part : ''
    end
    
    def development?
      @env == :development
    end
    
  end
end