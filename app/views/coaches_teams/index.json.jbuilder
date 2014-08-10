json.array!(@coaches_teams) do |coaches_team|
  json.extract! coaches_team, :id, :team_id, :coach_id, :headcoach
  json.url coaches_team_url(coaches_team, format: :json)
end
