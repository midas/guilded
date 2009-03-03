module Guilded
  module Exceptions
    
    class GuildedException < RuntimeError
      def initialize( msg="" )    #:nodoc:
        @msg = msg
      end
    end
    
    class IdMissing < GuildedException
      def initialize    #:nodoc:
        @msg = ":id for element must be present in the options hash"
      end
    end
    
    class DuplicateElementId < GuildedException
      def initialize( id='' )    #:nodoc:
        @msg = ":id #{id} for element is already in use on current page"
      end
    end
    
    class MissingConfiguration < GuildedException
      def initialize    #:nodoc:
        @msg = "There is no GUILDED_CONFIG instance.  Please load Guilded configuration with your apps initialization."
      end
    end
    
  end
end