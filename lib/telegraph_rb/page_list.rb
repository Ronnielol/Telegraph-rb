module Telegraph
  class PageList < Dry::Struct
    transform_keys(&:to_sym)

    attribute :total_count, Types::Strict::Integer
    attribute :pages, Types::Strict::Array.of(Page)

    def self.get(offset: 0, limit: 50)
      params = {
        offset: offset,
        limit: limit,
        access_token: client.token
      }
      response = client.get('getPageList', params)
      new(response)
    end

    private

    def self.client
      @client ||= Telegraph.client
    end
  end
end
