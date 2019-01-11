module Telegraph
  class Page < Dry::Struct
    transform_keys(&:to_sym)

    attribute :path, Telegraph::Types::Strict::String
    attribute :url, Telegraph::Types::Strict::String
    attribute :title, Telegraph::Types::Strict::String
    attribute :description, Telegraph::Types::Strict::String
    attribute :views, Telegraph::Types::Strict::Integer
    attribute :can_edit, Telegraph::Types::Bool.meta(omittable: true)
    attribute :author_name, Telegraph::Types::String
    attribute :author_url, Telegraph::Types::String.meta(omittable: true)
    attribute :content, Telegraph::Types::Array.meta(omittable: true)
  end
end
