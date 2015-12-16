class Tag
  include DataMapper::Resource
  property :id,    Serial
  property :tags, String
end
