json.array!(@ads) do |ad|
  json.extract! ad, :id, :name, :imageurl, :clickurl, :adtype, :active
  json.url ad_url(banner_ad, format: :json)
end
