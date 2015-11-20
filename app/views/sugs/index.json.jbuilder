json.array!(@sugs) do |sug|
  json.extract! sug, :id, :name, :description, :sugurl, :active
  json.url sug_url(sug, format: :json)
end
