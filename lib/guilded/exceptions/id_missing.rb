module Guilded
  module Exceptions
    
    class IdMissing < GuildedException
      def initialize    #:nodoc:
        @msg = ":id for element must be present in the options hash"
      end
    end
    
  end
end