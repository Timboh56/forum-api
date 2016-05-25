ActiveModel::Serializer.config.adapter = ActiveModel::Serializer::Adapter::JsonApi
ActiveModel::Serializer.config do |config|
  config.embed = :ids
  config.embed_in_root = true
end