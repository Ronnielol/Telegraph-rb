module Telegraph
  class Account < Dry::Struct
    extend Telegraph::Connection

    transform_keys(&:to_sym)

    attribute :access_token, Types::Strict::String.meta(omittable: true)
    attribute :short_name, Types::Strict::String
    attribute :author_name, Types::Strict::String
    attribute :auth_url, Types::Strict::String
    attribute :author_url, Types::Strict::String
    attribute :page_count, Types::String.meta(omittable: true)

    FIELDS = %w(short_name author_name author_url auth_url page_count)

    def self.create(short_name:, author_name:, author_url:)
      params = {
        short_name: short_name,
        author_name: author_name,
        author_url: author_url
      }
      response = post('createAccount', params)
      new(response)
    end

    def self.get(fields: [])
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
        access_token: access_token
      }
      response = client.get('editAccountInfo', params)
      new(response)
    end

    def revoke_token
      response = client.get('getAccountInfo', access_token: client.token)
      new(response)
    end

    def get_pages(offset: 0, limit: 50)
      params = {
        offset: offset,
        limit: limit,
        access_token: access_token
      }
      response = client.get('getPageList', params)
      response[:pages]
    end

    private

    def self.client
      @client ||= Telegraph.client
    end

    def client
      @client ||= Telegraph.client
    end
  end
end
