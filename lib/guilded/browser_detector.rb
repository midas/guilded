module Guilded 
  
  # The BrowserDetector provides the ability to determine browser information from the user 
  # agent string.
  #
  class BrowserDetector
    
    # Returns true if the browser matches the options ent in, otherwise returns false.
    #
    # === Request
    # * +request+ - The request object.
    #
    # === Options
    # * +:name+ - The name of the browser.  For example 'ie'.
    # * +:version+ - The version of the browser.  For example '7'.
    #
    def self.browser_is?( request, options={} )
      #name = name.to_s.strip
      name = options[:name].to_s.strip
      version = options[:version].to_s.strip

      return true if browser_name( request ) == name
      return true if name == 'mozilla' && browser_name( request ) == 'gecko'
      return true if name == 'ie' && browser_name( request ).index( 'ie' )
      return true if name == 'webkit' && browser_name( request ) == 'safari'
    end

    # Returns the name of the browser that is making this request.  For example 'ie'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def self.browser_name( request )
      @browser_name ||= begin
        ua = request.env['HTTP_USER_AGENT']
        if ua.nil?
          'unknown'
        else
          ua = ua.downcase  

          if ua.index( 'msie' ) && !ua.index( 'opera' ) && !ua.index( 'webtv' )
            if ua.index( 'windows ce' )
              'ie' + ua[ua.index( 'msie' ) + 5].chr + '_ce'
            else
              'ie' + ua[ua.index( 'msie' ) + 5].chr
            end
          elsif ua.index( 'netscape' )
            'netscape'
          elsif ua.index( 'gecko/' ) 
            'firefox'
          elsif ua.index( 'opera' )
            'opera'
          elsif ua.index( 'konqueror' ) 
            'konqueror'
          elsif ua.index( 'applewebkit/' )
            'safari'
          elsif ua.index( 'mozilla/' )
            'firefox'
          elsif ua.index( 'firefox' )
            'firefox'
          else
            'unknown'
          end
        end
      end
    end
    
    # Returns the browser name concatenated with the browser version.  for example, 'ie7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def self.browser_full_name( request )
      browser_name( request ) + browser_version( request )
    end

    # Returns the version of the browser that is making this request.  For example '7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def self.browser_version( request )
      @browser_version ||= begin
        ua = request.env['HTTP_USER_AGENT'].downcase

        if browser_name( request ) == 'opera'
          ua[ua.index( 'opera' ) + 6].chr
        elsif browser_name( request ) == 'firefox'
          ua[ua.index( 'firefox' ) + 8 ].chr
        elsif browser_name( request ) == 'netscape'
          ua[ua.index( 'netscape' ) + 9].chr
        elsif browser_name( request ).index( 'ie' )
          ua[ua.index( 'msie' ) + 5].chr
        else
          'unknown'
        end

      end
    end
    
    def self.can_use_png?
      if browser_name.index( 'ie' ) == 0
  		  if browser_version.to_i < 7 
  				false
  			else
  				true
  			end
  		#elsif browser_name == 'firefox'
  		  #	false
  		else
  			true
  		end
  	end

    def self.all_browsers
      %W( ie7, ie6, opera, firefox, netscape, konqueror, safari )
    end

    def self.all_mobile_browsers
      %w( ie4_ce )
    end

  end
end