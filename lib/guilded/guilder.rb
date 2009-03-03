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
    JS_PATH = "#{RAILS_ROOT}/public/javascripts/"
    CSS_PATH = "#{RAILS_ROOT}/public/stylesheets/"

    attr_reader :combined_js_srcs, :combined_css_srcs, :initialized_at
    
    def initialize( options={} ) #:nodoc:
      @initialized_at = Time.now
      @env = options[:env].to_sym if options[:env]
      @env ||= :production
      @g_elements = Hash.new
      @combined_js_srcs = Array.new
      @combined_css_srcs = Array.new
      @assets_combined = false
      # Make sure that the css reset file is first so that other files can override the reset,
      # unless the user specified no reset to be included.
      init_sources
    end
  
    # Adds an element with its options to the @g_elements hash to be used later.
    #
    def add( element, options={}, libs=[], styles=[] )
      raise Guilded::Exceptions::IdMissing unless options.has_key?( :id )
      raise Guilded::Exceptions::DuplicateElementId( options[:id] ) if @g_elements.has_key?( options[:id] )
      @g_elements[ options[:id] ] = Guilded::ComponentDef.new( element, options, libs, styles )
    end
  
    def count
      @g_elements.size
    end
    
    def component_count
      count
    end
    
    def style_count
      @combined_css_srcs.size
    end
    
    def script_count
      @combined_js_srcs.size
    end
    
    # Clears out all but the reset CSS and the base JavaScripts
    #
    def reset!
      @combined_css_srcs.clear
      @combined_js_srcs.clear
      @g_elements.clear
      init_sources
    end

    # Generates the markup required to include all the assets necessary for the Guilded compoents in 
    # @g_elements collection.  Use this if you are not interested in caching asset files.
    #
    def apply
      to_init = ""
      generate_asset_lists unless @assets_combined
      @combined_css_srcs.each { |css| to_init << "<link href=\"/stylesheets/#{css}\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />" }
      @combined_js_srcs.each { |js| to_init << "<script type=\"text/javascript\" src=\"/javascripts/#{js}\"></script>" }
      to_init << generate_javascript_init
      reset!
    end
    
    # Writes an initialization method that calls each Guilded components initialization method.  This 
    # method will exceute on document load finish.
    #
    def generate_javascript_init
      code = "<script type=\"text/javascript\">"
      code << "var initGuildedElements = function(){"
      @g_elements.each_value do |guilded_def| 
        code << "g.#{guilded_def.kind.to_s.camelize( :lower )}Init( #{guilded_def.options.to_json} );" unless guilded_def.exclude_js?
      end
      code << "};jQuery('document').ready( initGuildedElements );</script>"
    end
    
    def js_cache_name
      generate_js_cache_name( @combined_js_srcs )
    end
    
    def css_cache_name
      generate_css_cache_name( @combined_css_srcs )
    end
    
    def generate_js_cache_name( sources )      
      generate_asset_lists unless @assets_combined
      #return"#{controller.class.to_s.underscore}_#{controller.action_name}" if development?
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.js/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end
    
    def generate_css_cache_name( sources )
      generate_asset_lists unless @assets_combined
      #return "#{controller.class.to_s.underscore}_#{controller.action_name}" if development?
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.css/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end
    
  protected
    
    # Adds the Guilded reset CSS file and the guilded.js and jQuery files to the respective sources
    # collections.
    #
    def init_sources
      @combined_css_srcs << Guilded::Base::RESET_CSS #unless options[:reset] == false
      @combined_js_srcs << Guilded::Base::GUILDED_JS << Guilded::Base::JQUERY_JS
    end
    
    # Combines all JavaScript and CSS files into lists to include based on what Guilded components are on 
    # the current page.
    #
    def generate_asset_lists
      @assets_combined = true
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
    
    # Adds the guilded JS path to the the source name passed in.  When not in development mode,
    # it looks for a .pack.js, .min.jsm .compressed.js and chooses one of these over the 
    # development version.
    #
    def add_guilded_js_path( source )
      part = "#{GUILDED_JS_FOLDER}#{GUILDED_NS}#{source.to_s}"
      ext = 'js'
      
      return "#{part}.#{ext}" if development?
 
      #TODO Get rid of Rails specific code.
      possibles = {
        "#{JS_PATH}#{part}.pack.#{ext}" => "#{part}.pack.#{ext}",
        "#{JS_PATH}#{part}.min.#{ext}" => "#{part}.min.#{ext}",
        "#{JS_PATH}#{part}.compressed.#{ext}" => "#{part}.compressed.#{ext}",
        "#{JS_PATH}#{part}.#{ext}" => "#{part}.#{ext}"
      }
      
      possibles.each do |full_path, part_path|
        return part_path if File.exists?( full_path )           
      end
      
      "" # Should never reach here
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
      path = "#{CSS_PATH}#{part}"
      File.exists?( path ) ? part : ''
    end
    
    def development?
      @env == :development
    end
    
  end
end