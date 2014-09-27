json.array!(@results) do |result|
  json.extract! result, :id, :event_id, :result, :place, :teamscore, :opponentscore
  json.url result_url(result, format: :json)
end
