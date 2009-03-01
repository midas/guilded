module Guilded
  module Rails
    module ViewHelpers
   
      # Generates the JavaScript includes for each Guilded element that is used.  Also
      # generates the initGuildedElements function and includes a call to each GUIlded
      # elements Init method.
      #
      # Must be called once per rendered page.  You can include it just before the closing body 
      # tag of your application layout.  If no Guilded elements were called in the template, the 
      # call to g_apply_behavior will not output anything.
      #
      def g_apply_behavior
        Guilded::Guilder.instance.apply
      end
      
    end
  end
end