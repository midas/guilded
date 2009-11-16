module Guilded
  module Rails
    module ControllerActions
      
      def self.included( base )
        base.instance_eval do
          before_filter :reset_guilded
        end
        base.include( InstanceMethods )
      end

      module InstanceMethods
        def reset_guilded
          Guilded::Guilder.instance.reset!
        end
      end
      
    end
  end
end