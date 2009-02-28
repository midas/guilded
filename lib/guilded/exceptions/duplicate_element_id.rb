module Guilded
  module Exceptions
    
    class DuplicateElementId < GuildedException
      def initialize( id='' )    #:nodoc:
        @msg = ":id #{id} for element is already in use on current page"
      end
    end
      
  end
end
    