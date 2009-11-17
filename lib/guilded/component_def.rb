module Guilded
  class ComponentDef
    
    attr_reader :kind, :options, :libs, :styles
    attr_accessor :additional_js
  
    def initialize( kind, options={}, libs=[], styles=[], additional_js='' )
      @kind = kind
      @options = options
      @libs = libs
      @styles = styles
      @additional_js = additional_js
    end
    
    # True if this component does not include styles.
    #
    def exclude_css?
      options.include?( :exclude_css ) && ( options[:exclude_css] == 'true' || options[:exclude_css] == true )
    end
    
    #True if this componnent does not include JavaScript.
    def exclude_js?
      options.include?( :exclude_js ) && ( options[:exclude_js] == 'true' || options[:exclude_js] == true )
    end

  end
end