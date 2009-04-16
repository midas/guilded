module Guilded
  module Rails
    
    require 'active_support'
    
    # Common functionality that Rails Guilded components may need to use.
    #
    class Helpers
      
      # Resolves the REST path helper names and arguments from a ActiveRecord object(s).
      #
      def self.resolve_rest_path_helpers( ar_obj_col_or_class, options={} )        
        if ar_obj_col_or_class.is_a?( Array )
          ar_obj = ar_obj_col_or_class[0]
        elsif ar_obj_col_or_class.is_a?( ActiveRecord::Base )
          ar_obj = ar_obj_col_or_class
        elsif ar_obj_col_or_class.is_a?( Class )
          ar_obj = ar_obj_col_or_class.new
        end
        
        plural_ar_type = ar_obj.class.to_s.tableize
        singular_ar_type = plural_ar_type.singularize
        polymorphic_as = options[:polymorphic_as]
        polymorphic_type = options[:polymorphic_type]
        plural_polymorphic_type = polymorphic_type ? polymorphic_type.to_s.tableize : nil
        singular_polymorphic_type = polymorphic_type ? plural_polymorphic_type.singularize : nil
        plural_derived_type = polymorphic_type.nil? ? plural_ar_type : plural_polymorphic_type
        singular_derived_type = polymorphic_type.nil? ? singular_ar_type : singular_polymorphic_type
        pre = ""
        shallow_pre = ""
        scoped_by = Array.new
        shallow_scoped_by = Array.new
        helpers = Hash.new
        
        if options[:namespace]
          pre << "#{options[:namespace].to_s}_"
          shallow_pre << "#{options[:namespace].to_s}_" 
        end
        
        if options[:scoped_by]
          scoped_by = options[:scoped_by].is_a?( Array ) ? options[:scoped_by] : Array.new << options[:scoped_by]
          scoped_by.each_with_index do |scoper, i|
            scoper_name = scoper.class.to_s.tableize.singularize
            shallow_pre << "#{scoper_name}_" unless options[:shallow] && i == scoped_by.size-1
            pre << "#{scoper_name}_"
          end
          shallow_scoped_by = scoped_by.clone
          shallow_scoped_by.pop if options[:shallow]
        end
        
        helpers[:index_rest_helper] = "#{pre}#{plural_derived_type}_path"
        helpers[:index_rest_args] = scoped_by
        helpers[:show_rest_helper] = "#{shallow_pre}#{singular_derived_type}_path"
        helpers[:show_rest_args] = shallow_scoped_by
        helpers[:new_rest_helper] = "new_#{pre}#{singular_derived_type}_path"
        helpers[:new_rest_args] = scoped_by
        helpers[:edit_rest_helper] = "edit_#{shallow_pre}#{singular_derived_type}_path"
        helpers[:edit_rest_args] = shallow_scoped_by
        helpers[:delete_rest_helper] = "delete_#{shallow_pre}#{singular_derived_type}_path"
        helpers[:delete_rest_args] = shallow_scoped_by
        
        return helpers
      end
      
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