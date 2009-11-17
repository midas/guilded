module Guilded
  module Rails
    module ControllerActions
      
      def self.included( base )
        base.instance_eval do
          before_filter :reset_guilded
        end
        base.send( :include, InstanceMethods )
      end

      module InstanceMethods
        # Clears out the list of Guilded components prior to the next action executing.
        #
        def reset_guilded
          Guilded::Guilder.instance.reset!
        end
      end
      
    end
  end
end