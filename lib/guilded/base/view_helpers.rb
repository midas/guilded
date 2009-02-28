module Guilded
  module Base
    module ViewHelpers
   
      # Generates the javascript includes for each Guilded element that is used.  Also
      # generates the initGuildedElements function and includes a call to each GUIlded
      # elements Init method.
      #
      # Must be called once per rendered page.  You can include it just before the closing body 
      # tag of your application layout.  If no Guilded elements were called in the template, the 
      # call to g_apply_behavior will not output anything.
      #
      def g_apply_behavior( options={} )

        @g_elements.each_value do |guilded_def|
          #TODO get stylesheet (skin) stuff using rails caching
          combine_css_sources( guilded_def.kind, guilded_def.options[:skin], guilded_def.styles ) unless guilded_def.exclude_css?

          # Combine all JavaScript sources so that the caching option can be used on
          # the javascript_incldue_tag helper.
          combine_js_sources( guilded_def.kind, guilded_def.libs ) unless guilded_def.exclude_js?
        end

        # Add default styles
        Guilded::Base::COMMON_CSS.each do |style|
          @combined_css_srcs.push( style ) unless @combined_css_srcs.include?( style )
        end

        # Add default JavaScripts
        Guilded::Base::COMMON_JS.each do |item|
          @combined_js_srcs.push( item ) unless @combined_js_srcs.include?( item )
        end

        to_init << stylesheet_link_tag( @combined_css_srcs, :cache => "cache/#{generate_css_cache_name( @combined_js_srcs )}" )
        to_init << javascript_include_tag( @combined_js_srcs, :cache => "cache/#{generate_js_cache_name( @combined_js_srcs )}" )

        to_init << "<script type=\"text/javascript\">"
        to_init << "var initGuildedElements = function(){"

        @g_elements.each_value do |guilded_def| 
          unless guilded_def.exclude_js?
            to_init << " g.#{guilded_def.kind.to_s.camelize( :lower )}Init( #{guilded_def.options.to_json} );"
          end
        end

        to_init << "}; jQuery('document').ready( initGuildedElements ); </script>"
      end
      
    end
  end
end