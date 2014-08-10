json.array!(@athletes_teams) do |athletes_team|
  json.extract! athletes_team, :id, :athlete_id, :team_id, :captain, :jerseynumber, :position
  json.url athletes_team_url(athletes_team, format: :json)
end
