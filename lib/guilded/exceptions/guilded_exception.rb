module Guilded
  module Exceptions
    
    class GuildedException < RuntimeError
      
      def initialize( msg="" )    #:nodoc:
        @msg = msg
      end
      
    end
    
  end
end