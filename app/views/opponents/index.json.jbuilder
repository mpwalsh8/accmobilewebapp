json.array!(@opponents) do |opponent|
  json.extract! opponent, :id, :name, :mascot, :homevenue, :conferenceopponent
  json.url opponent_url(opponent, format: :json)
end
