require 'net/http'
require 'uri'

class AddressFinder
  ADDRESS_ACCESS_KEY = "f80dd2c405560fac7a01ab1be20c5b81"
  def initialize(query)
    @query = I18n.transliterate(query.strip)
  end

  def find_addresses
    
    uri = URI.parse("http://api.positionstack.com/v1/forward?access_key=#{ADDRESS_ACCESS_KEY}&query=#{@query}")
    response = Net::HTTP.get_response(uri)
    data = response.body
    
    JSON.parse(data)

  end
end