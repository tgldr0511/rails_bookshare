json.array!(@books) do |book|
  json.extract! book, :id, :title, :picture, :version, :year
  json.url book_url(book, format: :json)
end
