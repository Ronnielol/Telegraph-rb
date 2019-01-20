module Telegraph
  class NodeElement < Dry::Struct
    transform_keys(&:to_sym)

    attribute :tag, Types::Strict::String

    attribute :attrs, Types::Strict::String.meta(omittable: true)
    attribute :content, Types::Array.of(NodeElement).meta(omittable: true)
  end
end
