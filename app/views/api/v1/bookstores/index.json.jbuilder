json.array! @book_stores do |store|
  json.id store.id
  json.name store.name
  json.address store.address
  json.phone store.phone
  json.created_at store.created_at
  json.updated_at store.updated_at
end
