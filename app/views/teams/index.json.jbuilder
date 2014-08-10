json.array!(@teams) do |team|
  json.extract! team, :id, :name, :active, :url, :twitter, :gender, :varsity, :season, :sport_id
  json.url team_url(team, format: :json)
end
