module Telegraph
  class Page < Dry::Struct
    transform_keys(&:to_sym)

    attribute :path, Types::Strict::String
    attribute :url, Types::Strict::String
    attribute :title, Types::Strict::String
    attribute :description, Types::Strict::String
    attribute :views, Types::Strict::Integer
    attribute :author_name, Types::String

    attribute :can_edit, Types::Bool.meta(omittable: true)
    attribute :author_url, Types::String.meta(omittable: true)
    attribute :content, Types::Array.of(NodeElement).meta(omittable: true)

    class << self
      def create(title:, author_name:, author_url:, content:, return_content: false)
        params = {
          title: title,
          author_name: author_name,
          author_url: author_url,
          content: content,
          return_content: return_content,
          access_token: client.token
        }
        response = client.post('createPage', params)
        new(response)
      end

      def get(path:, return_content: false)
        params = {
          path: path,
          return_content: return_content,
          access_token: client.token
        }
        response = client.get('getPage', params)
        new(response)
      end

      def get_views(path:, year: nil, month: nil, day: nil, hour: nil)
        params = { path: path }
        time_params = {
          year: year,
          month: month,
          day: day,
          hour: hour
        }
        params.merge(time_params) if time_params.values.compact.any?
        response = client.get('getViews', params)
        response[:views]
      end

      def edit(path:, title:, content:, author_name: nil, author_url: nil)
        params = {
          path: path,
          title: title,
          content: content,
          author_name: author_name,
          author_url: author_url,
          access_token: client.token
        }
        response = client.post('editPage', params)
        new(response)
      end

      private

      def client
        @client ||= Telegraph.client
      end
    end
  end
end
