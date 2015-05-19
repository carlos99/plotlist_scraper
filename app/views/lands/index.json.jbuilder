json.array!(@lands) do |land|
  json.extract! land, :id, :heading, :body, :price, :neigborhood, :external_url, :timestamp
  json.url land_url(land, format: :json)
end
