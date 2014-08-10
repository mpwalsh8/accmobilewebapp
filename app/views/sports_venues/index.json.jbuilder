json.array!(@sports_venues) do |sports_venue|
  json.extract! sports_venue, :id, :sport_id, :venue_id
  json.url sports_venue_url(sports_venue, format: :json)
end
