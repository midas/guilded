require 'digest'
require 'singleton'
require 'guilded/exceptions'

module Guilded

  # Guilder is the worker for the entire Guilded framework.  It collects all of the necessary components for a page
  # through its add() method.  When the g_apply_behavior() method is called at the end of a page, the Guilder writes
  # HTML to include all of the necessary asset files (caching them in production).  It also writes a JavaScript initialization
  # function and fires the initialization function on page load and a before and after initialization callback allowing for
  # custom initializtion to occur.
  #
  # This initialization function calls the initialization function for each Guilded component that was added to the current
  # page.  For example, if a Guilded component named 'g_load_alerter' was added to a page, the Guilder would include this line
  # in the initialization function it writes: g.initLoadAlerter( /* passing options hash here */ );  The g before the function
  # is a JavaScript namespace that Guilded automatically creates to facilitate avoiding name collisions with other JavaScript
  # libraries and code.
  #
  # Th options hash that is passed to the init functions for each Guilded component is simply the options hash from the
  # component's view helper.  The Guilder calls .to_json() on the options hash.  Thus, if there are pairs in the options hash
  # that need not go to the JavaScript init method they should be removed within the view helper.
  #
  class Guilder
    include Singleton

    GUILDED_NS = "guilded."

    attr_reader :initialized_at, :jquery_js, :mootools_js

    def initialize #:nodoc:
      if defined?( GUILDED_CONFIG )
        @config = GUILDED_CONFIG
      else
        raise Guilded::Exceptions::MissingConfiguration
      end
      configure_guilded
      @initialized_at = Time.now
      @g_elements = {}
      @g_data_elements = {}
      @combined_js_srcs = []
      @combined_css_srcs = []
      @css_temp_hold = { :pre => [], :post => [], :components => [], :reset => [] }
      @valid_css_positions = @css_temp_hold.keys
      # Make sure that the css reset file is first so that other files can override the reset,
      # unless the user specified no reset to be included.
      init_sources
    end

    # Adds an element with its options to the @g_elements hash to be used later.
    #
    def add( element, options={}, libs=[], styles=[] )
      raise Guilded::Exceptions::IdMissing.new unless options.has_key?( :id )
      raise Guilded::Exceptions::DuplicateElementId.new( options[:id] ) if @g_elements.has_key?( options[:id] )
      @need_mootools = true if options[:mootools]
      @g_elements[ options[:id].to_sym ] = Guilded::ComponentDef.new( element, options, libs, styles )
    end

    # Adds a data structure to be passed to the Guilded JavaScript environment for use on the client
    # side.  The data is passed using the ruby to_json method on the data structure provided.
    #
    # === Parameters
    # * +name+ - The desired name of the variable on the client side.
    # * +data+ - The data to pass to the Guilded JavaScript environment.
    #
    def add_data( name, data )
      @g_data_elements.merge!( name.to_sym => data )
    end

    # Adds JavaScript sources to the libs collection by resolving them to the normal or min version
    # based on the current running environment, development, production, etc.
    #
    def add_js_sources( *sources )
      resolve_js_libs( *sources )
    end

    def add_css_source( src, position=:post )
      @css_temp_hold[position.to_sym] << src unless @css_temp_hold[position.to_sym].include?( src )
    end

    def count #:nodoc:
      @g_elements.size
    end

    # The number of Guilded components to be renderred.
    #
    def component_count
      count
    end

    # The current number of CSS assets necessary for the Guilded component set.
    #
    def style_count
      @combined_css_srcs.size
    end

    # The current number of JavaScript assets necessary for the Guilded component set.
    #
    def script_count
      @combined_js_srcs.size
    end

    # Returns true if the component type is included, otherwise false.
    #
    def include_component?( type )
      @g_elements.has_key?( type.to_sym )
    end

    # The collection of JavaScript assets for the current Guilded component set.
    #
    def combined_js_srcs
      @combined_js_srcs
    end

    # The collection of CSS assets for the current Guilded component set.
    #
    def combined_css_srcs
      @css_temp_hold[:reset].each { |src| @combined_css_srcs << src }
      @css_temp_hold[:pre].each { |src| @combined_css_srcs << src }
      @css_temp_hold[:components].each { |src| @combined_css_srcs << src }
      @css_temp_hold[:post].each { |src| @combined_css_srcs << src }
      @combined_css_srcs
    end

    # Clears out all but the reset CSS and the base JavaScripts
    #
    def reset!
      @combined_css_srcs.clear
      @combined_js_srcs.clear
      @g_elements.clear
      @css_temp_hold = { :pre => [], :post => [], :components => [], :reset => [] }
      @valid_css_positions = @css_temp_hold.keys
      init_sources
      @default_css_count = @combined_css_srcs.size
      @default_js_count = @combined_js_srcs.size
    end

    def inject_css( *sources )
      @combined_css_srcs.insert( @default_css_count, *sources )
    end

    def inject_js( *sources )
      @combined_js_srcs.insert( @default_js_count, *sources )
    end

    # Generates the markup required to include all the assets necessary for the Guilded compoents in
    # @g_elements collection.  Use this if you are not interested in caching asset files.
    #
    def apply #:nodoc:
      to_init = ""
      generate_asset_lists #unless @assets_combined
      @combined_css_srcs.each { |css| to_init << "<link href=\"/stylesheets/#{css}\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />" }
      @combined_js_srcs.each { |js| to_init << "<script type=\"text/javascript\" src=\"/javascripts/#{js}\"></script>" }
      to_init << generate_javascript_init
      reset!
    end

    # Writes an initialization method that calls each Guilded components initialization method.  This
    # method will exceute on document load finish.
    #
    def generate_javascript_init( options={} ) #:nodoc:
      options[:include_script_tags] = true if options[:include_script_tags].nil?
      code = ""

      if options[:include_script_tags]
        code << "<script type=\"text/javascript\">\n//<![CDATA[\n"
      end

      code << "var initGuildedElements = function(){"
      @g_data_elements.each do |name, data|
        code << "g.#{name} = #{data.to_json};"
      end
      @g_elements.each_value do |guilded_def|
        code << "g.#{guilded_def.kind.to_s.camelize( :lower )}Init(#{guilded_def.options.to_json});" unless guilded_def.exclude_js?
      end
      code << "jQuery('body').trigger('guildedInitialized');};jQuery('document').ready(initGuildedElements);"

      if options[:include_script_tags]
        code << "\n\n//]]>\n</script>"
      end

      code
    end

    # Generates a name to use when caching the current set of Guilded component JavaScript assets.  Sorts and concatenates
    # the name of each JavaScript asset in @combined_js_srcs.  Then hashes this string to generate a reproducible, unique
    # and shorter string.
    #
    def js_cache_name
      generate_js_cache_name( @combined_js_srcs )
    end

    # Generates a name to use when caching the current set of Guilded component CSS assets.  Sorts and concatenates
    # the name of each JavaScript asset in @combined_js_srcs.  Then hashes this string to generate a reproducible, unique
    # and shorter string.
    #
    def css_cache_name
      name = generate_css_cache_name( @combined_css_srcs )
      name
    end

    def generate_js_cache_name( sources ) #:nodoc:
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.js/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end

    def generate_css_cache_name( sources ) #:nodoc:
      sorted_srcs = sources.sort
      stripped_srcs = sorted_srcs.map { |src| src.gsub( /.css/, '' ).gsub( /\//, '_') }
      joined = stripped_srcs.join( "+" )
      "#{Digest::MD5.hexdigest( joined )}"
    end

    # Combines all JavaScript and CSS files into lists to include based on what Guilded components are on
    # the current page.
    #
    def generate_asset_lists #:nodoc:
      @g_elements.each_value do |defi|
        #TODO get stylesheet (skin) stuff using rails caching
        combine_css_sources( defi.kind, defi.options[:skin], defi.styles ) unless defi.exclude_css?

        # Combine all JavaScript sources so that the caching option can be used on
        # the javascript_incldue_tag helper.
        combine_js_sources( defi.kind, defi.libs ) unless defi.exclude_js?
      end
    end

    def jquery_js
      @config[:jquery_js]
    end

    def jquery_remote_url
      @config[:jquery_remote_url]
    end

    def use_remote_jquery
      @config[:use_remote_jquery]
    end

    def app_root
      @config[:app_root]
    end

    def environment
      @config[:environment]
    end

    def development? #:nodoc:
      environment.to_sym == :development
    end

    def production? #:nodoc:
      environment.to_sym == :production
    end

    def test? #:nodoc:
      environment.to_sym == :test
    end

  protected

    def configure_guilded #:nodoc:
      @js_path = @config[:js_path]
      @js_folder = @config[:js_folder]
      @jquery_js = @config[:jquery_js]
      @mootools_js = @config[:mootools_js]
      @jquery_folder = @config[:jquery_folder] || 'jquery/'
      @mootools_folder = @config[:mootools_folder] || 'mootools/'
      @guilded_js = 'guilded.min.js'
      @url_js = 'jquery-url.min.js'
      @css_path = @config[:css_path]
      @css_folder = @config[:css_folder]
      @reset_css = @config[:reset_css]
      @env = @config[:environment]
      @env ||= :production
      @js_path.freeze
      @css_path.freeze
      @js_folder.freeze
      @guilded_js.freeze
      @url_js.freeze
      @jquery_js.freeze
      @jquery_folder.freeze
      @mootols_js.freeze
      @mootools_folder.freeze
      @guilded_js.freeze
      @css_folder.freeze
      @reset_css.freeze
      @env.freeze
    end

    # Adds the Guilded reset CSS file and the guilded.js and jQuery files to the respective sources
    # collections.
    #
    def init_sources #:nodoc:
      @css_temp_hold[:reset] << "#{@reset_css}" unless @reset_css.nil? || @reset_css.empty?
      resolve_js_libs( "#{@jquery_js}", "#{@jquery_folder}#{@url_js}", "#{@js_folder}#{@guilded_js}" )
      #TODO include the jQuery lib from Google server in production
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
    def combine_js_sources( component, libs=[] )  #:nodoc:
      libs << @mootools_js if @need_mootools
      resolve_js_libs( *libs )

      comp_src = add_guilded_js_path( component )
      @combined_js_srcs.push( comp_src ) unless @combined_js_srcs.include?( comp_src )
    end

    # Helper method that adds the aditional JavaScript library icludes to the include set.
    #
    # If running development mode, it will try to remove any .pack, .min, or.compressed
    # parts fo the name to try and get the debug version of the library.  If it cannot
    # find the debug version of the file, it will just remain what was initially provded.
    #
    def resolve_js_libs( *libs ) #:nodoc:
      if development?
        # Try to use an unpacked or unminimized version
        libs.each do |lib|
          debug_lib = lib.gsub( /.pack/, '' ).gsub( /.min/, '' ).gsub( /.compressed/, '' )
          path = "#{app_root}/public/javascripts/#{debug_lib}"
          if File.exist?( path )
            @combined_js_srcs.push( debug_lib ) unless @combined_js_srcs.include?( debug_lib )
          else
            @combined_js_srcs.push( lib ) unless @combined_js_srcs.include?( lib )
          end
        end
      else
        libs.each { |lib| @combined_js_srcs.push( lib ) unless @combined_js_srcs.include?( lib ) }
      end
    end

    # Helper method that takes an array of js sources and adds the correct guilded
    # path to them.  Returns an array with the new path resolved sources.
    #
    def map_guilded_js_paths( *sources ) #:nodoc:
      sources.map { |source| add_guilded_js_path( source ) }
    end

    # Adds the guilded JS path to the the source name passed in.  When not in development mode,
    # it looks for a .pack.js, .min.jsm .compressed.js and chooses one of these over the
    # development version.
    #
    def add_guilded_js_path( source ) #:nodoc:
      part = "#{@js_folder}#{GUILDED_NS}#{source.to_s}"
      ext = 'js'

      return "#{part}.#{ext}" unless production?

      possibles = [ "#{@js_path}#{part}.min.#{ext}", "#{@js_path}#{part}.pack.#{ext}", "#{@js_path}#{part}.compressed.#{ext}",
        "#{@js_path}#{part}.#{ext}" ]
      parts = [ "#{part}.min.#{ext}", "{part}.pack.#{ext}", "#{part}.compressed.#{ext}", "#{part}.#{ext}" ]

      possibles.each_with_index do |full_path, i|
        return parts[i] if File.exists?( full_path )
      end

      "" # Should never reach here
    end

    def combine_css_sources( component, skin, styles=[] ) #:nodoc:
      # Get all of this components defined external styles
      styles.each do |style|
        @css_temp_hold[:components].push( style ) unless @css_temp_hold[:components].include?( style )
      end

      #Get the default or guilded skin styles for this component
      comp_src = add_guilded_css_path( component, skin )
      @css_temp_hold[:components].push( comp_src ) unless @css_temp_hold[:components].include?( comp_src ) || comp_src.empty?
      user_src = add_guilded_css_path( component, "user" )
      @css_temp_hold[:components].push( user_src ) unless @css_temp_hold[:components].include?( user_src ) || user_src.empty?
      skin_user_src = add_guilded_css_path( component, "#{skin || 'default'}_user" )
      @css_temp_hold[:components].push( skin_user_src ) unless @css_temp_hold[:components].include?( skin_user_src ) || skin_user_src.empty?
    end

    def add_guilded_css_path( source, skin ) #:nodoc:
      skin = 'default' if skin.nil? || skin.empty?
      part = "#{@css_folder}#{source.to_s}/#{skin}.css"
      path = "#{@css_path}#{part}"
      File.exists?( path ) ? part : ''
    end
  end
end