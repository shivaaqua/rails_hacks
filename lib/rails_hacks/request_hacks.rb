require 'uri'

# class ActionController::AbstractRequest
#   def referer_host
#     begin
#       @referer_host ||= URI.parse(headers['HTTP_REFERER']).host if headers['HTTP_REFERER']
#     rescue URI::InvalidURIError
#       'localhost'
#     end
#   end
#   
#   def referer_path
#     URI.parse(headers['HTTP_REFERER']).path if headers['HTTP_REFERER']
#   end
# end