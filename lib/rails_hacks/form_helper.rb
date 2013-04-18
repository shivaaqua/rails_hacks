
module ActionView
  module Helpers
    module TagHelper
      def tag_with_type_class(name, options = nil, open = false, escape = true)
        if options
          options = options.with_indifferent_access
          options.merge_dom_class! options[:type] if name.to_sym == :input and options[:type]
        end

        tag_without_type_class name, options, open, escape
      end
      alias_method_chain :tag, :type_class
    end
    
    # I don't know why these don't work with tag_with_type_class
    # because to_input_field_tag calls tag, but for some reason
    # tag_with_type_class does not get called
    class InstanceTag
    
      def to_input_field_tag_with_type_class(field_type, options = {})             
        options.merge_dom_class! field_type
        to_input_field_tag_without_type_class field_type, options
      end
      alias_method_chain :to_input_field_tag, :type_class
      
      def to_radio_button_tag_with_type_class(tag_value, options = {})        
        options.merge_dom_class! 'radio'
        to_radio_button_tag_without_type_class tag_value, options
      end
      alias_method_chain :to_radio_button_tag, :type_class
      
      def to_check_box_tag_with_type_class(options = {}, checked_value = "1", unchecked_value = "0")        
        options.merge_dom_class! 'checkbox'
        to_check_box_tag_without_type_class options, checked_value, unchecked_value
      end
      
      alias_method_chain :to_check_box_tag, :type_class
      
    end
  end
end