json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :address, :googlemapsurl, :phone, :url, :twitter, :latlong
  json.url venue_url(venue, format: :json)
end
