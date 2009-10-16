module Guilded 
  
  # The BrowserDetector provides the ability to determine browser information from the user 
  # agent string.
  #
  class BrowserDetector
    
    attr_reader :ua
    
    def initialize( user_agent )
      @ua = user_agent.downcase
      @version_regex = /(\d*)\.(\d*)\.*(\d*)\.*(\d*)/
    end
    
    # Returns true if the browser matches the options ent in, otherwise returns false.
    #
    # === Request
    # * +request+ - The request object.
    #
    # === Options
    # * +:name+ - The name of the browser.  For example 'ie' or :ie.
    # * +:version+ - The version of the browser.  For example '3.0.5'.
    # * +:major_version+ - The major version of the browser.  For example '3' or 3.
    # * +:minor_version+ - The minor version of the browser.  For example '0' or 0.
    #
    def browser_is?( options={} )
      name = options[:name]
      version = options[:version]
      major_version = options[:major_version]
      minor_version = options[:minor_version]
      build_version = options[:build_version]
      revision_version = options[:revision_version]
      
      name ||= self.browser_name
      version ||= self.browser_version
      major_version ||= self.browser_version_major
      minor_version ||= self.browser_version_minor
      build_version ||= self.browser_version_build
      revision_version ||= self.browser_version_revision

      name = name.to_s.strip
      version = version.to_s.strip
      major_version = major_version.to_s.strip
      minor_version = minor_version.to_s.strip
      build_version = build_version.to_s.strip
      revision_version = revision_version.to_s.strip
      
      self.browser_name == name && self.browser_version == version && self.browser_version_major == major_version &&
        self.browser_version_minor == minor_version #&& self.browser_version_build == build_version && 
        #self.browser_version_revision == revision_version
    end

    # Returns the name of the browser that is making this request.  For example 'ie'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_name
      begin
        @browser_name ||= begin
          ua = @ua
          if ua.nil?
            'unknown'
          else
            if ua.index( 'msie' ) && !ua.index( 'opera' ) && !ua.index( 'webtv' )
              if ua.index( 'windows ce' )
                'ie' + '_ce' #+ ua[ua.index( 'msie' ) + 5].chr 
              else
                'ie' # + ua[ua.index( 'msie' ) + 5].chr
              end
            elsif ua.include?( 'opera' )
              'opera'
            elsif ua.include?( 'konqueror' ) 
              'konqueror'
            elsif ua.include?( 'applewebkit/' )
              'safari'
            elsif ua.include?( 'chrome' )
              'chrome'
            #elsif ua.include?( 'mozilla/' )
            #  'firefox'
            elsif ua.include?( 'firefox' )
              'firefox'
            #elsif ua.include?( 'gecko/' ) 
            #  'firefox'
            elsif ua.include?( 'netscape' )
              'netscape'
            else
              'unknown'
            end
          end
        end
      rescue
        'unknown'
      end
    end

    # Returns the version of the browser that is making this request.  For example '7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_version
      @browser_version ||= begin
        self.send( "resolve_version_for_#{self.browser_name}".to_sym )
      end
    end

    def browser_version_major
      match = @version_regex.match( browser_version )
      return match[1].to_i.to_s unless match.nil? || match.size < 2
      '0'
    end

    def browser_version_minor
      match = @version_regex.match( browser_version )
      return match[2].to_i.to_s unless match.nil? || match.size < 3
      '0'
    end
    
    def browser_version_build
      match = @version_regex.match( browser_version )
      return match[3].to_i.to_s unless match.nil? || match.size < 4 || match[3].empty? || match[3].nil?
      '0'
    end
    
    def browser_version_revision
      match = @version_regex.match( browser_version )
      return match[4].to_i.to_s unless match.nil? || match.size < 5 || match[4].empty? || match[4].nil?
      '0'
    end
    
    # Returns the browser name concatenated with the browser version.  for example, 'ie7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_full_name
      self.send( "browser_full_name_for_#{self.browser_name}".to_sym )
    end
    
    # Returns the browser name concatenated with the browser version.  for example, 'ie7'.
    #
    # === Request
    # * +request+ - The request object.
    #
    def browser_id
      browser_name + browser_version.gsub( /\./, '' )
    end
    
    # Returns true if the current browser type can handle PNGs.
    #
    def can_use_png?
      return browser_version.to_i >= 7 if browser_name== 'ie'
    	true
  	end

    # A list of all the browser types that Guilded recognizes.
    #
    def self.all_browsers
      %w( chrome firefox ie55 ie60 ie70 ie80 konqueror netscape opera safari )
    end

    # A list of all the mobile browser types that Guilded recognizes.
    #
    def self.all_mobile_browsers
      %w( ie_ce4 iphone )
    end
    
    def self.user_agents
      { 
        :ie55 => 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1)', 
        :ie60 => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)',
        :ie70 => 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)',
        :ie80 => 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)',
        :firefox2 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.17) Gecko/20080829 Firefox/2.0.0.17',
        :firefox3 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.0.11) Gecko/2009060214 Firefox/3.0.11',
        :firefox35 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3',
        :firefox35win => 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3 (.NET CLR 3.5.30729)',
        :opera10 => 'Opera/9.80 (Macintosh; Intel Mac OS X; U; en) Presto/2.2.15 Version/10.00'
      }
    end
    
    protected
    
    def resolve_version_for_ie
      match = /.*msie (.*); windows nt 5.1/.match( @ua )
      return match.nil? ? '0' : match[1]
    end
    
    def resolve_version_for_firefox
      match = /.*\((.*); u;.*firefox\/(.*) \(.net.*/.match( @ua )
      if match.nil?
        match = /.*\((.*); u;.*firefox\/(.*)/.match( @ua )
        return match.nil? ? '0' : match[2]
      end
      return match.nil? ? '0' : match[2]
    end
    
    def resolve_version_for_opera
      match = /.*\((.*); intel.*version\/(.*)/.match( @ua )
      return match.nil? ? '0' : match[2]
    end
    
    def browser_full_name_for_ie
      "Internet Explorer #{browser_version}"
    end
    
    def browser_full_name_for_firefox
      "Firefox #{browser_version}"
    end
    
    def browser_full_name_for_opera
      "Opera #{browser_version}"
    end
    
  end
end