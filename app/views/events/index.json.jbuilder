json.array!(@events) do |event|
  json.extract! event, :id, :teamid, :opponentid, :venueid, :type, :eventdatetime, :eventduration
  json.url event_url(event, format: :json)
end
