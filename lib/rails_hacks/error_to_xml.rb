class Exception
  
  # Example:
  #   rescue MO::Handler::PreconditionError => e
  #     render :xml => e.to_xml, :status => :precondition_failed
  #   end
  def to_xml    
    Builder::XmlMarkup.new.exception(message, :type => self.class.to_s.underscore)
  end
end