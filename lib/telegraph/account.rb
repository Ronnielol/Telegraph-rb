module Telegraph
  class Account
    attr_reader :access_token, :short_name, :author_name, :auth_url, :author_url, :page_count

    def initialize(attrs)
      @access_token = client.token
      @short_name = attrs['short_name']
      @author_name = attrs['author_name']
      @auth_url = attrs['auth_url']
      @author_url = attrs['author_url']
      @page_count = attrs['page_count']
    end

    private

    def client
      @client ||= Telegraph.client
    end
  end
end