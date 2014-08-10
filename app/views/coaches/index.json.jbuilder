json.array!(@coaches) do |coach|
  json.extract! coach, :id, :firstname, :middlename, :lastname, :nickname, :active, :email, :twitter
  json.url coach_url(coach, format: :json)
end
