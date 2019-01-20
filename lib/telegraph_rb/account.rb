module Telegraph
  class Account < Dry::Struct
    extend Telegraph::Connection

    transform_keys(&:to_sym)

    attribute :author_url, Types::Strict::String
    attribute :short_name, Types::Strict::String
    attribute :author_name, Types::Strict::String

    attribute :access_token, Types::Strict::String.meta(omittable: true)
    attribute :auth_url, Types::String.meta(omittable: true)
    attribute :page_count, Types::String.meta(omittable: true)

    FIELDS = %w(short_name author_name author_url auth_url page_count)

    class << self
      def create(short_name:, author_name:, author_url:)
        params = {
          short_name: short_name,
          author_name: author_name,
          author_url: author_url
        }
        response = post('createAccount', params)
        new(response)
      end

      def get(fields: [])
        fields = FIELDS unless fields.any?
        params = {
          fields: fields,
          access_token: client.token
        }
        response = client.get('getAccountInfo', params)
        new(response)
      end

      def edit(short_name:, author_name:, author_url:)
        params = {
          short_name: short_name,
          author_name: author_name,
          author_url: author_url,
          access_token: client.token
        }
        response = client.post('editAccountInfo', params)
        new(response)
      end

      def revoke_token
        response = client.post('getAccountInfo', access_token: client.token)
        new(response)
      end

      private

      def client
        @client ||= Telegraph.client
      end
    end
  end
end
