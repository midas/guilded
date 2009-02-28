module Guilded
  class Guilder

    # The folder name for guilded JavaScript files.  Must include trailing '/'.
    GUILDED_JS_FOLDER = "guilded/"
    # The folder name for guilded css files.  Must include trailing '/'.
    GUILDED_CSS_FOLDER = "guilded/"
    GUILDED_NS = "guilded."
  
    attr_reader :g_elements, :combined_js_srcs, :combined_css_srcs
  
    def initialize( options={} ) #:nodoc:
      @g_elements = Hash.new #unless @g_elements
      @combined_js_srcs = Array.new #if @combined_js_srcs.nil?
      @combined_css_srcs = Array.new #if @combined_css_srcs.nil?
    
      # Make sure that the css reset file is first so that other files can override the reset,
      # unless the user specified no reset to be included.
      @combined_css_srcs.insert( 0, Guilded::Base::RESET_CSS ) unless options[:reset] == false
      @combined_js_srcs.insert( 0, Guilded::Base::GUILDED_JS ) unless @combined_js_srcs.include?( Guilded::Base::GUILDED_JS )
      @combined_js_srcs.insert( 0, Guilded::Base::JQUERY_JS ) unless @combined_js_srcs.include?( Guilded::Base::JQUERY_JS )
      #TODO find a way to get the resolve js libs to work on these two so we get the non-min version in development
    end
  
    # Adds an element with its options to the @g_elements hash to be used later.
    #
    def add_to_inits( element, options={}, libs=[], styles=[] )
      raise Guilded::Exceptions::IdMissing unless options.has_key?( :id )
      raise Guilded::Exceptions::DuplicateElementId( options[:id] ) if @g_elements && @g_elements.has_key?( options[:id] )
      @g_elements = Hash.new unless @g_elements
      @g_elements[ options[:id] ] = Guilded::ComponentDef.new( element, options, libs, styles )
    end
    
    # Generates the markup required to include all the assets necessary for the Guilded compoents in 
    # @g_elements collection.
    #
    def apply
      to_init = ""
      
      @g_elements.each_value do |guilded_def|
        #TODO get stylesheet (skin) stuff using rails caching
        combine_css_sources( guilded_def.kind, guilded_def.options[:skin], guilded_def.styles ) unless guilded_def.exclude_css?

        # Combine all JavaScript sources so that the caching option can be used on
        # the javascript_incldue_tag helper.
        combine_js_sources( guilded_def.kind, guilded_def.libs ) unless guilded_def.exclude_js?
      end

      # Add default styles
      Guilded::Base::COMMON_CSS.each do |style|
        @combined_css_srcs.push( style ) unless @combined_css_srcs.include?( style )
      end

      # Add default JavaScripts
      Guilded::Base::COMMON_JS.each do |script|
        @combined_js_srcs.push( script ) unless @combined_js_srcs.include?( script )
      end

      to_init << stylesheet_link_tag( @combined_css_srcs, :cache => "cache/#{generate_css_cache_name( @combined_js_srcs )}" )
      to_init << javascript_include_tag( @combined_js_srcs, :cache => "cache/#{generate_js_cache_name( @combined_js_srcs )}" )

      to_init << "<script type=\"text/javascript\">"
      to_init << "var initGuildedElements = function(){"

      @g_elements.each_value do |guilded_def| 
        unless guilded_def.exclude_js?
          to_init << " g.#{guilded_def.kind.to_s.camelize( :lower )}Init( #{guilded_def.options.to_json} );"
        end
      end

      to_init << "}; jQuery('document').ready( initGuildedElements ); </script>"
    end
    
    protected
    
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
      #combined_src = Array.new
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
      if Rails.env.development?
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
      
      if Rails.env.development?
        "#{part}.#{ext}"
      else
 
        possibles = {
          "#{RAILS_ROOT}/public/javascripts/#{part}.pack.#{ext}" => "#{part}.pack.#{ext}",
          "#{RAILS_ROOT}/public/javascripts/#{part}.min.#{ext}" => "#{part}.min.#{ext}",
          "#{RAILS_ROOT}/public/javascripts/#{part}.compressed#{ext}" => "#{part}.compressed#{ext}",
          "#{RAILS_ROOT}/public/javascripts/#{part}.#{ext}" => "#{part}.#{ext}"
        }
        
        possibles.each do |full_path, part_path|
          return part_path if File.exists?( full_path )           
        end
      end 
    end
  
  end
end