module Guilded 
  
  # The BrowserDetector provides the ability to determine browser information from the user 
  # agent string.
  #
  class BrowserDetector
    
    def initialize( request )
      @request = request
    end
    
    # Returns true if the browser matches the options ent in, otherwise returns false.
    #
    # === Request
    # * +request+ - The request object.
    #
    # === Options
    # * +:name+ - The name of the browser.  For example 'ie'.
    # * +:version+ - The version of the browser.  For example '7'.
    #
    def browser_is?( options={} )
      name = options[:name].to_s.strip
      version = options[:version].to_s.strip

      return true if browser_name == name
      return true if name == 'mozilla' && browser_name == 'gecko'
      #return true if name == 'ie' && browser_name.index( 'ie' )
      return true if name == 'webkit' && browser_name == 'safari'
    end

    # Returns the name of the browser that is making this request.  For example 'ie'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_name
      begin
        @browser_name ||= begin
          ua = @request.env['HTTP_USER_AGENT']
          if ua.nil?
            'unknown'
          else
            ua = ua.downcase  

            if ua.index( 'msie' ) && !ua.index( 'opera' ) && !ua.index( 'webtv' )
              if ua.index( 'windows ce' )
                'ie' + '_ce' #+ ua[ua.index( 'msie' ) + 5].chr 
              else
                'ie' # + ua[ua.index( 'msie' ) + 5].chr
              end
            elsif ua.include?( 'chrome' )
              'chrome'
            elsif ua.include?( 'netscape' )
              'netscape'
            elsif ua.include?( 'gecko/' ) 
              'firefox'
            elsif ua.include?( 'opera' )
              'opera'
            elsif ua.include?( 'konqueror' ) 
              'konqueror'
            elsif ua.include?( 'applewebkit/' )
              'safari'
            elsif ua.include?( 'mozilla/' )
              'firefox'
            elsif ua.include?( 'firefox' )
              'firefox'
            else
              'unknown'
            end
          end
        end
      rescue
        'unknown'
      end
    end
    
    # Returns the browser name concatenated with the browser version.  for example, 'ie7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_full_name
      browser_name + browser_version
    end

    # Returns the version of the browser that is making this request.  For example '7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_version
      begin
        @browser_version ||= begin
          ua = @request.env['HTTP_USER_AGENT'].downcase

          if browser_name == 'opera'
            ua[ua.index( 'opera' ) + 6].chr
          elsif browser_name == 'chrome'
            ua[ua.index( 'chrome' ) + 7].chr
          elsif browser_name == 'firefox'
            ua[ua.index( 'firefox' ) + 8].chr
          elsif browser_name == 'netscape'
            ua[ua.index( 'netscape' ) + 9].chr
          elsif browser_name.index( 'ie' )
            ua[ua.index( 'msie' ) + 5].chr
          elsif browser_name.index( 'safari' )
            ua[ua.index( 'version' ) + 8].chr
          else
            '0'
          end
        end
      rescue
        '0'
      end
    end
    
    def can_use_png?
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
      %W( ie8, ie7, ie6, opera, firefox, netscape, konqueror, safari )
    end

    def self.all_mobile_browsers
      %w( ie_ce4 )
    end
    
  end
end