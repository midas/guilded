module Guilded
  module Rails
    
    # Common functionality that Rails Guilded components may need to use.
    #
    class Helpers
      
      # Helper method that generates a path from an item.  If item is :home then this method
      # will call the home_path method to generate a link
      #
      def self.generate_link( item )
        begin
          link_path = @controller.send( "#{item.to_s}_path" )
        rescue => e
          if e.is_a? NoMethodError
            link_path = ''
          else
            throw e
          end
        end
        link_path
      end

      # Helper method that takes an array of choices, each being a string, symbol or hash,
      # and resolves it into two arrays, one being an array of method names to get a fields
      # value and the other being an array of titles to display the field as.
      #
      def self.resolve_field_methods_and_titles( choices, ar_obj )
        titles = Array.new
        methods = Array.new

        choices.each do |choice|
          if choice.is_a? Hash
            if choice.to_a[0][1].is_a? Symbol
              titles.push( choice.to_a[0][1].to_s.humanize.titleize )
            else
              titles.push( choice.to_a[0][1] )
            end
            if choice.to_a[0][0].is_a? Symbol
              methods.push( choice.to_a[0][0].to_s )
            else
              methods.push( choice.to_a[0][0] )
            end
          else
            title = nil
            begin
              title = ar_obj.class.human_attribute_name( choice )
            rescue => ex
              title = choice.to_s.humanize.titleize if ex.is_a?( NoMethodError )
            end
            titles.push( title )
            methods.push( choice.to_s )
          end
        end

        return methods, titles
      end
      
    end
    
  end
end