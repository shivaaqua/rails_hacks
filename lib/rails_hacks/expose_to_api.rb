# expects to be included by ActiveRecord::Base
module ExposeToApi
  
  # Basically, this method sets up some defaults for ActiveRecord calls to .to_xml.
  # used to only show certain fields to
  # be sure to also use attr_accessible
  # 
  # == Arguments:
  # 
  # arguments to expose_to_api are a list of attributes to pass to to_xmls :only option, and an optional hash of options
  #
  # == Options:
  #   for:: this allows you to setup a scope, see examples below
  #   skip_id:: normally, expose_to_api automatically adds the :id attribute for you, this allows you to disable that feature
  # all other options are passed on to to_xml
  #
  # == Example:
  #   # with these in your model   
  #   expose_to_api :name, :username
  #   expose_to_api :name, :for => :feed, :skip_id => true
  #
  #   instance.to_xml
  #   # is equivalent to
  #   instance.to_xml :only => [ :id, :name, :username ]
  #   # and
  #   instance.to_xml :for => :feed
  #   # is equivalent to
  #   instance.to_xml :only => [ :name ]
  def expose_to_api(*args)
    options = args.extract_options!
    args |= [:id] unless options.delete(:skip_id)
    options.merge!(:only => args)
    
    if options[:for]
      option_for = options.delete(:for)
      class_variable_set "@@expose_to_api_for_#{option_for}", options
      class_eval <<-EOS_FOR, __FILE__, __LINE__
        def to_xml_with_expose_to_api_for_#{option_for}(options = {})
          if options[:for] and options[:for].to_sym == :#{option_for}
            method = respond_to?(:to_xml_without_expose_to_api) ? :to_xml_without_expose_to_api : :to_xml
            send method, options.merge(@@expose_to_api_for_#{option_for})
          else
            to_xml_without_expose_to_api_for_#{option_for}(options)
          end
        end
        alias_method_chain :to_xml, :expose_to_api_for_#{option_for}
      EOS_FOR
    else
      class_variable_set "@@expose_to_api", options
      class_eval <<-EOS, __FILE__, __LINE__
        def to_xml_with_expose_to_api(options = {})
          to_xml_without_expose_to_api(options.merge(@@expose_to_api))
        end
        alias_method_chain :to_xml, :expose_to_api
      EOS
    end
  end

end

ActiveRecord::Base.send :extend, ExposeToApi