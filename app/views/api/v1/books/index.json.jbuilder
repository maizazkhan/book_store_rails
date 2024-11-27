json.array! @books do |book|
  json.id  book.id
  json.title book.title
  json.author book.author
  json.publisher book.publisher
  json.genre book.genre
  json.year book.year
  json.page_count book.page_count
  json.description book.description
  json.price book.price
  json.created_at book.created_at
  json.updated_at book.updated_at
end
