module InactiveRecord
  class Base
    class <<self
      def attr_human_hint(attributes) # :nodoc:
        #return unless table_exists?

        attributes.stringify_keys!
        write_inheritable_hash("attr_human_hint", attributes || {})

        # assign the current class to each column that is being assigned a new human attribute name
        self.columns.reject{|c| !attributes.has_key?(c.name)}.each{|c| c.parent_record_class = self}
      end

      # Returns a hash of alternate human name conversions set with <tt>attr_human_name</tt>.
      def human_hint_attributes # :nodoc:
        read_inheritable_attribute("attr_human_hint")
      end

      # Transforms attribute key names into a more humane format, such as "First name" instead of "first_name". Example:
      #   Person.human_attribute_name("first_name") # => "First name"
      def human_attribute_hint(attribute_key_name) #:nodoc:
        (read_inheritable_attribute("attr_human_hint") || {})[attribute_key_name.to_s] || ''
      end
    end
  end
end