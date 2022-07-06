class StaticMap
  STATIC_MAP_ACCESS_KEY = "05c373c8887e4a839299959075cc1540"
  def initialize(lat, long)
    @lat, @long = lat, long
  end

  def get_image 
    "https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=400&marker=lonlat:#{@long},#{@lat}&zoom=15&apiKey=#{STATIC_MAP_ACCESS_KEY}"
  end
end